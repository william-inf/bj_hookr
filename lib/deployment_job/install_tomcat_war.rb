require_relative '../../lib/common/job_template'
require_relative '../../lib/common/remote_file_system_helpers'
require_relative '../../lib/common/local_file_system_helpers'

class InstallTomcatWar < JobTemplate

  JOB_NAME = 'InstallTomcatWar'

  def initialize(config)
    super(JOB_NAME, config)
  end

  def process
    super do
      @config.keys.each do |key|
        validate_config(@config[key], %w(host user password war_file_path app_name))
        logger.debug "Beginning installation of war file [#{key}]"
        ssh_details = {
            host: @config[key]['host'],
            user: @config[key]['user'],
            password: @config[key]['password']
        }
        app_name = @config[key]['app_name']
        war_file_path = @config[key]['war_file_path']
        RemoteFileSystemHelpers.install_war_file(app_name, war_file_path, ssh_details)
      end
    end
  end
end
