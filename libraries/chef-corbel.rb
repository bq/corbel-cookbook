class Chef
	module Corbel
		# A shortcut to a customer
    def corbel_install(name)
			include_recipe "supervisor"
			include_recipe "java"

      app = node[:corbel][name]

      setup_directory(app[:deploy_to])

      #Download the application package
      maven_deploy name do
        artifact_id app[:artifact_id]
        group_id app[:group_id]
        version app[:version]
        classifier app[:classifier]
        packaging "tar.gz"
        deploy_to "#{app[:deploy_to]}/#{name}.tar.gz"
        notifies :delete,  "directory[#{app[:deploy_to]}/#{name}]", :immediately
        notifies :create,  "directory[#{app[:deploy_to]}/#{name}]", :immediately
        notifies :extract_local, "tar_extract[#{app[:deploy_to]}/#{name}.tar.gz]", :immediately
      end

      #Module Directory
      directory "#{app[:deploy_to]}/#{name}" do
        recursive true
        action :nothing
      end

      #Extract the application
      tar_extract "#{app[:deploy_to]}/#{name}.tar.gz" do
        action :nothing
        target_dir "#{app[:deploy_to]}"
        creates "#{app[:deploy_to]}/#{name}/bin"
        if app.has_key?(:owner) then
          owner app[:owner]
        end
        if app.has_key?(:group) then
          group app[:group]
        end

        notifies :restart, "supervisor_service[#{name}]" , :delayed
      end

      install_plugins(app, name)

			supervisor_service name do
  			action [:enable, :start]
  			autostart true
  			user app[:owner] if app[:owner]
				command "#{app[:deploy_to]}/#{name}/bin/#{name} server"
			end
    end

    def setup_directory(dir)
      #Create deploy directory
      directory dir do
        recursive true
        action :create
      end
    end

    def install_plugins(app, name)
      #Install plugins
      (app[:plugins] || []).each do | plugin_id, plugin_data |
        maven_deploy plugin_id do
          group_id plugin_data[:group_id]
          artifact_id plugin_data[:artifact_id]
          version plugin_data[:version]
          deploy_to "#{app[:deploy_to]}/#{name}/plugins/#{plugin_id}.jar"
          notifies :restart, "supervisor_service[#{name}]" , :delayed
        end
      end
    end

    def corbel_docker_install(name)
      include_recipe "docker"

      app = node[:corbel][name]
      config_dir = "#{app[:deploy_to]}/#{name}/etc"

      setup_directory(app[:deploy_to])
      install_plugins(app, name)

      docker_container name do
        action :redeploy
        image "#{app[:docker_image]}:#{app[:version]}"
        detach true
        force true
        port app[:docker_ports]
        volume ["#{app[:deploy_to]}/#{name}/plugins:/#{name}/plugins", "#{config_dir}/environment.properties:/#{name}/etc/environment.properties"]
        link app[:docker_link]
        retries 2
      end
      service name do 
        action :nothing
      end
    end

    def corbel_docker_configure(name)
      corbel_configure(name, 'service')
    end

    def corbel_configure(name, service="supervisor_service")
			app = node[:corbel][name]
      config_dir = "#{app[:deploy_to]}/#{name}/etc"

      log_config = app[:log]
      template "#{config_dir}/logback.xml" do
        only_if { log_config }
        source "logger/logback.xml.erb"
        mode 0444
        variables({
          :config => log_config
        })
      end

      config = app[:config]
      template "#{config_dir}/environment.properties" do
        only_if { config }
        source "environment.properties.erb"
        mode 0444
        variables({
          :config => config
        })
				notifies :restart, "#{service}[#{name}]" , :delayed
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

    def corbel_run_scripts(name)
      scripts = (node[:corbel][name][:scripts] || [])
      script_paths = Array.new

      scripts.each do | script |
        script_path = "/tmp/#{name}/#{script}"
        directory File.dirname(script_path) do
          recursive true
          action :create
        end
        create_file(script, script_path)
        script_paths << script_path
      end

      if scripts.any? then
        execute "Running #{name} scripts: #{script_paths}" do
          command "#{node[:corbel][name][:deploy_to]}/#{name}/bin/#{name} cli #{script_paths.join(' ')}"
        end

        script_paths.each do | script_path |
          file script_path do
            action :delete
          end
        end
      end
    end

    def create_file(script_src, script_path)
      # Parsing the script_src. token is the current parsing token
      token = script_src
      protocol = "file"
      cookbook = nil
      # first try to parse the protocol
      parts = token.split("://")
      if parts.length == 2 then
        protocol = parts[0]
        token = parts[1]
      end
      # Then try to parse the cookbook where the script is located
      parts = token.split(":")
      if parts.length == 2 then
        cookbook = parts[0]
        token = parts[1]
      end
      self.send(protocol+"_script", cookbook, token, script_path)
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
	end
end

Chef::Recipe.send(:include, Chef::Corbel)
