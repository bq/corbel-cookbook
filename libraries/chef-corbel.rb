class Chef
  module Corbel
    # A shortcut to a customer
    def corbel_install(name, binary = name)
      include_recipe 'supervisor'
      include_recipe 'java'

      app = node[:corbel][name]
      config_dir = "#{app[:deploy_to]}/#{name}/etc"

      setup_directory(app[:deploy_to])
      setup_directory(config_dir)

      # Download the application package
      maven_deploy name do
        artifact_id app[:artifact_id]
        group_id app[:group_id]
        version app[:version]
        classifier app[:classifier]
        packaging 'tar.gz'
        deploy_to "#{app[:deploy_to]}/#{name}.tar.gz"
        notifies :delete,  "directory[#{app[:deploy_to]}/#{name}]", :immediately
        notifies :create,  "directory[#{app[:deploy_to]}/#{name}]", :immediately
        notifies :extract_local, "tar_extract[#{app[:deploy_to]}/#{name}.tar.gz]", :immediately
      end

      # Module Directory
      directory "#{app[:deploy_to]}/#{name}" do
        recursive true
        action :nothing
      end

      # Extract the application
      tar_extract "#{app[:deploy_to]}/#{name}.tar.gz" do
        action :nothing
        target_dir "#{app[:deploy_to]}"
        creates "#{app[:deploy_to]}/#{name}/bin"
        if app.key?(:owner)
          owner app[:owner]
        end
        if app.key?(:group)
          group app[:group]
        end

        notifies :restart, "supervisor_service[#{binary}]", :delayed
      end

      install_plugins(app, name, binary)

      supervisor_service name do
        action [:enable, :start]
        autostart true
        user app[:owner] if app[:owner]
        environment ({
          'JAVA_OPTS' => app[:jvm_arguments]
        })
        command "#{app[:deploy_to]}/#{name}/bin/#{binary} server"
      end
   end

    def setup_directory(dir)
      # Create deploy directory
      directory dir do
        recursive true
        action :create
      end
    end

    def docker_install_plugins(app, name, binary = name)
      install_plugins(app, name, binary, 'docker_container')
    end

    def install_plugins(app, name, binary, service = 'supervisor_service')
      # Install plugins
      (app[:plugins] || []).each do | plugin_id, plugin_data |
        maven_deploy plugin_id do
          group_id plugin_data[:group_id]
          artifact_id plugin_data[:artifact_id]
          version plugin_data[:version]
          classifier plugin_data[:classifier] if plugin_data[:classifier]
          packaging plugin_data[:packaging] if plugin_data[:packaging]
          useMavenMetadata false if plugin_data[:style] == 'ivy'
          deploy_to "#{app[:deploy_to]}/#{name}/plugins/#{plugin_id}.jar"
          notifies :restart, "#{service}[#{binary}]", :delayed
        end
      end
    end

    def corbel_docker_install(name)
      docker_service 'default' do
        action [:create, :start]
      end

      if node['docker'] && node['docker']['docker_daemon_timeout'] && node['docker']['docker_daemon_timeout'] < 1200
        node.set['docker']['docker_daemon_timeout'] = 1200
      end

      app = node[:corbel][name]
      config_dir = "#{app[:deploy_to]}/#{name}/etc"
      docker_port = as_list(app[:docker_ports])
      docker_link = as_list(app[:docker_link])

      setup_directory(app[:deploy_to])
      setup_directory(config_dir)

      #setup config file
      file "#{config_dir}/environment.properties" do
        action :create_if_missing
      end
      file "#{config_dir}/logback.xml" do
        action :create_if_missing
      end

      docker_install_plugins(app, name)

      docker_image app[:docker_image] do
        tag "#{app[:version]}"
        action :pull
        notifies :redeploy, "docker_container[#{name}]", :immediately
      end

      docker_container name do
        image "#{app[:docker_image]}"
        tag "#{app[:version]}"
        container_name name
        env ["JAVA_OPTS=#{app[:jvm_arguments]}"]
        detach true
        force true
        port docker_port
        binds ["#{app[:deploy_to]}/#{name}/plugins:/#{name}/plugins",
        "#{config_dir}/environment.properties:/#{name}/etc/environment.properties",
        "/tmp/#{name}:/tmp/#{name}",
        "#{config_dir}/logback.xml:/#{name}/etc/logback.xml"]
        links docker_link
        retries 2
      end
    end

    def corbel_docker_configure(name, binary = name)
      corbel_configure(name, binary, 'docker_container')
    end

    def corbel_configure(name, binary = name, service = 'supervisor_service')
      app = node[:corbel][name]
      config_dir = "#{app[:deploy_to]}/#{name}/etc"

      template "#{config_dir}/logback.xml" do
        source 'logger/logback.xml.erb'
        mode 0444
        variables(
          config: app[:log]
        )
      end

      config = app[:config]
      template "#{config_dir}/environment.properties" do
        only_if { config }
        source 'environment.properties.erb'
        mode 0444
        variables(
          config: config
        )
        notifies :restart, "#{service}[#{binary}]", :delayed
      end
    end

    def copy_files(name)
      (node[:corbel][name][:files] || []).each do | file |
        scriptName = File.basename(file[:src])
        file_path = "#{node[:corbel][name][:deploy_to]}/#{name}/#{file[:dst]}/#{scriptName}"
        directory File.dirname(file_path) do
          recursive true
          action :create
        end
        create_file(file[:src], file_path)
      end
    end

    def corbel_run_scripts(name, binary = name, cmd = "#{node[:corbel][name][:deploy_to]}/#{name}/bin/#{binary}")
      if node[:cli][:launch_scripts]
        scripts = (node[:corbel][name][:scripts] || [])
        script_paths = []
        scripts.each do | script |
          src = parse_script_src(script)
          script_path = "/tmp/#{name}/#{src[:path]}"
          directory File.dirname(script_path) do
            recursive true
            action :create
          end
          create_file(src, script_path)
          script_paths << script_path
        end

        if scripts.any?
          execute "Running #{name} scripts: #{script_paths}" do
            command "#{cmd} cli #{script_paths.join(' ')}"
          end

          script_paths.each do | script_path |
            file script_path do
              action :delete
            end
          end
        end
      else
        Chef::Log.info("Skip launch scripts!")
      end
    end

    def corbel_docker_run_scripts(name, binary = name)
      corbel_run_scripts(name, binary, "docker exec #{name} /#{name}/bin/#{binary}")
    end

    def create_file(src, script_path)
      src = src.is_a?(String) ? parse_script_src(src) : src
      send(src[:protocol] + '_script', src[:cookbook], src[:path], script_path)
    end

    def parse_script_src(script_src)
      # Parsing the script_src. token is the current parsing token
      token = script_src
      script = Hash.new
      script[:protocol] = 'file'
      script[:cookbook] = nil

      # first try to parse the protocol
      parts = token.split('://')
      if parts.length == 2
        script[:protocol] = parts[0]
        token = parts[1]
      end
      # Then try to parse the cookbook where the script is located
      parts = token.split(':')
      if parts.length == 2
        script[:cookbook] = parts[0]
        token = parts[1]
      end

      script[:path] = token
      script #return
    end

    def file_script(cookbook, script, script_path)
      cookbook_file script_path do
        cookbook cookbook unless cookbook.nil?
        source script
        mode 0755
      end
    end

    def template_script(cookbook, script, script_path)
      template script_path do
        cookbook cookbook unless cookbook.nil?
        source script
        mode 0755
      end
    end

    def as_list(value)
      if value.is_a? String
        value.split(',').map {|s| s.strip}
      else
        value
      end
    end
  end
end

Chef::Recipe.send(:include, Chef::Corbel)
