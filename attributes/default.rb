#Module defaults
default[:corbel][:iam][:type] = "tarball"
default[:corbel][:iam][:artifact_id] = "iam"
default[:corbel][:iam][:group_id] = "io.corbel"
default[:corbel][:iam][:version] = "LATEST"
default[:corbel][:iam][:classifier] = "bin"
default[:corbel][:iam][:deploy_to] = "/opt/corbel"
default[:corbel][:iam][:docker_image] = "corbel/iam"
default[:corbel][:iam][:docker_link] = "mongo:mongo, redis:redis, rabbitmq:rabbitmq"
default[:corbel][:iam][:docker_ports] = "8082:8082, 8083:8083"
default[:corbel][:iam][:scripts] = ['scripts/iam/iam-scopes.groovy', 'scripts/iam/evci-scopes.groovy', 'scripts/iam/webfs-scopes.groovy', 'scripts/iam/composite-scopes.groovy']
default[:corbel][:iam][:log][:root][:level] = "INFO"
default[:corbel][:iam][:log][:console][:enabled] = true
default[:corbel][:iam][:log][:file][:enabled] = false
default[:corbel][:iam][:log][:file][:level] = "INFO"
default[:corbel][:iam][:log][:file][:currentLogFilename] = "/var/log/corbel/iam.log"
default[:corbel][:iam][:log][:file][:archivedLogFilenamePattern] = "/var/log/corbel/iam-%d.log.gz"
default[:corbel][:iam][:log][:syslog][:enabled] = false
default[:corbel][:iam][:log][:syslog][:level] = "INFO"
default[:corbel][:iam][:log][:syslog][:host] = "localhost"
default[:corbel][:iam][:log][:syslog][:port] = 10514
default[:corbel][:iam][:log][:syslog][:ident] = "iam"
default[:corbel][:iam][:log][:syslog][:maxMessageLength] = "128000"


default[:corbel][:resources][:type] = "tarball"
default[:corbel][:resources][:artifact_id] = "resources"
default[:corbel][:resources][:group_id] = "io.corbel"
default[:corbel][:resources][:version] = "LATEST"
default[:corbel][:resources][:classifier] = "bin"
default[:corbel][:resources][:deploy_to] = "/opt/corbel"
default[:corbel][:resources][:docker_image] = "corbel/resources"
default[:corbel][:resources][:docker_link] = "mongo:mongo, redis:redis, rabbitmq:rabbitmq, elasticsearch:elasticsearch"
default[:corbel][:resources][:docker_ports] = "8080:8080, 8081:8081"
default[:corbel][:resources][:log][:root][:level] = "INFO"
default[:corbel][:resources][:log][:console][:enabled] = true
default[:corbel][:resources][:log][:file][:enabled] = false
default[:corbel][:resources][:log][:file][:level] = "INFO"
default[:corbel][:resources][:log][:file][:currentLogFilename] = "/var/log/corbel/resources.log"
default[:corbel][:resources][:log][:file][:archivedLogFilenamePattern] = "/var/log/corbel/resources-%d.log.gz"
default[:corbel][:resources][:log][:syslog][:enabled] = false
default[:corbel][:resources][:log][:syslog][:level] = "INFO"
default[:corbel][:resources][:log][:syslog][:host] = "localhost"
default[:corbel][:resources][:log][:syslog][:port] = 10514
default[:corbel][:resources][:log][:syslog][:ident] = "resources"
default[:corbel][:resources][:log][:syslog][:maxMessageLength] = "128000"


default[:corbel][:webfs][:type] = "tarball"
default[:corbel][:webfs][:artifact_id] = "webfs"
default[:corbel][:webfs][:group_id] = "io.corbel"
default[:corbel][:webfs][:version] = "LATEST"
default[:corbel][:webfs][:classifier] = "bin"
default[:corbel][:webfs][:deploy_to] = "/opt/corbel"
default[:corbel][:webfs][:docker_image] = "corbel/webfs"
default[:corbel][:webfs][:docker_link] = "mongo:mongo, redis:redis, rabbitmq:rabbitmq"
default[:corbel][:webfs][:docker_ports] = "8096:8096, 8097:8097"
default[:corbel][:webfs][:log][:root][:level] = "INFO"
default[:corbel][:webfs][:log][:console][:enabled] = true
default[:corbel][:webfs][:log][:file][:enabled] = false
default[:corbel][:webfs][:log][:file][:level] = "INFO"
default[:corbel][:webfs][:log][:file][:currentLogFilename] = "/var/log/corbel/webfs.log"
default[:corbel][:webfs][:log][:file][:archivedLogFilenamePattern] = "/var/log/corbel/webfs-%d.log.gz"
default[:corbel][:webfs][:log][:syslog][:enabled] = false
default[:corbel][:webfs][:log][:syslog][:level] = "INFO"
default[:corbel][:webfs][:log][:syslog][:host] = "localhost"
default[:corbel][:webfs][:log][:syslog][:port] = 10514
default[:corbel][:webfs][:log][:syslog][:ident] = "webfs"
default[:corbel][:webfs][:log][:syslog][:maxMessageLength] = "128000"


default[:corbel][:evci][:type] = "tarball"
default[:corbel][:evci][:artifact_id] = "evci"
default[:corbel][:evci][:group_id] = "io.corbel"
default[:corbel][:evci][:version] = "LATEST"
default[:corbel][:evci][:classifier] = "bin"
default[:corbel][:evci][:deploy_to] = "/opt/corbel"
default[:corbel][:evci][:docker_image] = "corbel/evci"
default[:corbel][:evci][:docker_link] = "mongo:mongo, redis:redis, rabbitmq:rabbitmq"
default[:corbel][:evci][:docker_ports] = "8086:8086, 8087:8087"
default[:corbel][:evci][:log][:root][:level] = "INFO"
default[:corbel][:evci][:log][:console][:enabled] = true
default[:corbel][:evci][:log][:file][:enabled] = false
default[:corbel][:evci][:log][:file][:level] = "INFO"
default[:corbel][:evci][:log][:file][:currentLogFilename] = "/var/log/corbel/evci.log"
default[:corbel][:evci][:log][:file][:archivedLogFilenamePattern] = "/var/log/corbel/evci-%d.log.gz"
default[:corbel][:evci][:log][:syslog][:enabled] = false
default[:corbel][:evci][:log][:syslog][:level] = "INFO"
default[:corbel][:evci][:log][:syslog][:host] = "localhost"
default[:corbel][:evci][:log][:syslog][:port] = 10514
default[:corbel][:evci][:log][:syslog][:ident] = "evci"
default[:corbel][:evci][:log][:syslog][:maxMessageLength] = "128000"

default[:corbel][:oauth][:type] = "tarball"
default[:corbel][:oauth][:artifact_id] = "oauth-server"
default[:corbel][:oauth][:group_id] = "io.corbel"
default[:corbel][:oauth][:version] = "LATEST"
default[:corbel][:oauth][:classifier] = "bin"
default[:corbel][:oauth][:deploy_to] = "/opt/corbel"
default[:corbel][:oauth][:docker_image] = "corbel/oauth-server"
default[:corbel][:oauth][:docker_link] = "mongo:mongo, rabbitmq:rabbitmq"
default[:corbel][:oauth][:docker_ports] = "8084:8084, 8085:8085"
default[:corbel][:oauth][:log][:root][:level] = "INFO"
default[:corbel][:oauth][:log][:console][:enabled] = true
default[:corbel][:oauth][:log][:file][:enabled] = false
default[:corbel][:oauth][:log][:file][:level] = "INFO"
default[:corbel][:oauth][:log][:file][:currentLogFilename] = "/var/log/corbel/oauth-server.log"
default[:corbel][:oauth][:log][:file][:archivedLogFilenamePattern] = "/var/log/corbel/oauth-server-%d.log.gz"
default[:corbel][:oauth][:log][:syslog][:enabled] = false
default[:corbel][:oauth][:log][:syslog][:level] = "INFO"
default[:corbel][:oauth][:log][:syslog][:host] = "localhost"
default[:corbel][:oauth][:log][:syslog][:port] = 10514
default[:corbel][:oauth][:log][:syslog][:ident] = "oauth-server"
default[:corbel][:oauth][:log][:syslog][:maxMessageLength] = "128000"

#JAVA defaults
default[:java][:install_flavor] = "oracle"
default[:java][:oracle][:accept_oracle_download_terms] = true
default[:java][:jdk_version] = "8"

#Service console scripts launch by default
default[:cli][:launch_scripts] = true
