require_relative '../../lib/common/job_template'
require_relative '../../lib/common/remote_file_system_helpers'
require_relative '../../lib/common/ssh_processor'

class SSHSession < JobTemplate

  JOB_NAME = 'ssh_session'

  def initialize
    super(JOB_NAME)
  end

  def process
    config = TaskModuleHelper.get_task_module[@name]
    super do
      config.keys.each do |key|
        validate_config(config[key], %w(host user password task_list))
        logger.debug "Beginning installation of war file [#{key}]"
        ssh_details = {
            host: config[key]['host'],
            user: config[key]['user'],
            password: config[key]['password']
        }
        task_list = config[key]['task_list']
        RemoteFileSystemHelpers.process_ssh_requests(task_list, ssh_details)
      end
    end
  end
end
