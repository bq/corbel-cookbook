#Module defaults
default[:corbel][:iam][:type] = "tarball"
default[:corbel][:iam][:artifact_id] = "iam"
default[:corbel][:iam][:group_id] = "com.bq.oss.corbel"
default[:corbel][:iam][:version] = "LATEST"
default[:corbel][:iam][:classifier] = "bin"
default[:corbel][:iam][:deploy_to] = "/opt/corbel"
default[:corbel][:iam][:docker_image] = "corbel/iam"
default[:corbel][:iam][:docker_link] = "mongo:mongo, redis:redis, rabbitmq:rabbitmq"
default[:corbel][:iam][:docker_ports] = "8082:8082, 8083:8083"
default[:corbel][:iam][:scripts] = ['scripts/iam/iam-scopes.groovy', 'scripts/iam/evci-scopes.groovy', 'scripts/iam/webfs-scopes.groovy', 'scripts/iam/composite-scopes.groovy']
default[:corbel][:iam][:log][:file][:enabled] = false
default[:corbel][:iam][:log][:file][:level] = "INFO"
default[:corbel][:iam][:log][:file][:currentLogFilename] = "/var/log/corbel/iam.log"
default[:corbel][:iam][:log][:file][:archivedLogFilenamePattern] = "/var/log/corbel/iam-%d.log.gz"
default[:corbel][:iam][:log][:syslog][:enabled] = false
default[:corbel][:iam][:log][:syslog][:level] = "INFO"
default[:corbel][:iam][:log][:root][:level] = "INFO"


default[:corbel][:resources][:type] = "tarball"
default[:corbel][:resources][:artifact_id] = "resources"
default[:corbel][:resources][:group_id] = "com.bq.oss.corbel"
default[:corbel][:resources][:version] = "LATEST"
default[:corbel][:resources][:classifier] = "bin"
default[:corbel][:resources][:deploy_to] = "/opt/corbel"
default[:corbel][:resources][:docker_image] = "corbel/resources"
default[:corbel][:resources][:docker_link] = "mongo:mongo, redis:redis, rabbitmq:rabbitmq, elasticsearch:elasticsearch"
default[:corbel][:resources][:docker_ports] = "8080:8080, 8081:8081"
default[:corbel][:resources][:log][:file][:enabled] = false
default[:corbel][:resources][:log][:file][:level] = "INFO"
default[:corbel][:resources][:log][:file][:currentLogFilename] = "/var/log/corbel/resources.log"
default[:corbel][:resources][:log][:file][:archivedLogFilenamePattern] = "/var/log/corbel/resources-%d.log.gz"
default[:corbel][:resources][:log][:syslog][:enabled] = false
default[:corbel][:resources][:log][:syslog][:level] = "INFO"
default[:corbel][:resources][:log][:root][:level] = "INFO"


default[:corbel][:webfs][:type] = "tarball"
default[:corbel][:webfs][:artifact_id] = "webfs"
default[:corbel][:webfs][:group_id] = "com.bq.oss.corbel"
default[:corbel][:webfs][:version] = "LATEST"
default[:corbel][:webfs][:classifier] = "bin"
default[:corbel][:webfs][:deploy_to] = "/opt/corbel"
default[:corbel][:webfs][:docker_image] = "corbel/webfs"
default[:corbel][:webfs][:docker_link] = "mongo:mongo, redis:redis, rabbitmq:rabbitmq"
default[:corbel][:webfs][:docker_ports] = "8096:8096, 8097:8097"
default[:corbel][:webfs][:log][:file][:enabled] = false
default[:corbel][:webfs][:log][:file][:level] = "INFO"
default[:corbel][:webfs][:log][:file][:currentLogFilename] = "/var/log/corbel/webfs.log"
default[:corbel][:webfs][:log][:file][:archivedLogFilenamePattern] = "/var/log/corbel/webfs-%d.log.gz"
default[:corbel][:webfs][:log][:syslog][:enabled] = false
default[:corbel][:webfs][:log][:syslog][:level] = "INFO"
default[:corbel][:webfs][:log][:root][:level] = "INFO"

default[:corbel][:evci][:type] = "tarball"
default[:corbel][:evci][:artifact_id] = "evci"
default[:corbel][:evci][:group_id] = "com.bq.oss.corbel"
default[:corbel][:evci][:version] = "LATEST"
default[:corbel][:evci][:classifier] = "bin"
default[:corbel][:evci][:deploy_to] = "/opt/corbel"
default[:corbel][:evci][:docker_image] = "corbel/evci"
default[:corbel][:evci][:docker_link] = "mongo:mongo, redis:redis, rabbitmq:rabbitmq"
default[:corbel][:evci][:docker_ports] = "8086:8086, 8087:8087"
default[:corbel][:evci][:log][:file][:enabled] = false
default[:corbel][:evci][:log][:file][:level] = "INFO"
default[:corbel][:evci][:log][:file][:currentLogFilename] = "/var/log/corbel/evci.log"
default[:corbel][:evci][:log][:file][:archivedLogFilenamePattern] = "/var/log/corbel/evci-%d.log.gz"
default[:corbel][:evci][:log][:syslog][:enabled] = false
default[:corbel][:evci][:log][:syslog][:level] = "INFO"
default[:corbel][:evci][:log][:root][:level] = "INFO"

#JAVA defaults
default[:java][:install_flavor] = "oracle"
default[:java][:oracle][:accept_oracle_download_terms] = true
default[:java][:jdk_version] = "8"
