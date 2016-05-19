require_relative '../../lib/common/job_template'
require_relative '../../lib/common/remote_file_system_helpers'
require_relative '../../lib/common/local_file_system_helpers'

class DeployRemoteFiles < JobTemplate

  JOB_NAME = 'deploy_remote_files'

  def initialize
    super(JOB_NAME)
  end

  def process
    config = TaskModuleHelper.get_task_module[@name]
    super do
      config.keys.each do |key|
        validate_config(config[key], %w(local_path remote_path host user password))
        logger.debug "Beginning deployment of remote files [#{key}]"
        local_path = config[key]['local_path']
        remote_path = config[key]['remote_path']
        ssh_details = {
            host: config[key]['host'],
            user: config[key]['user'],
            password: config[key]['password']
        }

        RemoteFileSystemHelpers.copy_remote_files(local_path, remote_path, ssh_details)
      end
    end
  end

end