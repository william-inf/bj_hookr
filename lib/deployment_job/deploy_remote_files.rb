require_relative '../../lib/deployment_job/job_template'
require_relative '../../lib/common/remote_file_system_helpers'
require_relative '../state/task_state_levels'

class DeployRemoteFiles < JobTemplate

  def initialize(config)
    super('DeployRemoteFiles', config)
  end

  def process
    @state.trigger(TaskStateLevels::PROCESSING)
    @config.keys.each do |key|
      logger.debug "Beginning deployment of remote files [#{key}]"
      local_path = @config[key]['local_path']
      remote_path = @config[key]['remote_path']
      ssh_details = {
          host: @config[key]['host'],
          user: @config[key]['user'],
          password: @config[key]['password']
      }

      RemoteFileSystemHelpers.copy_remote_files(local_path, remote_path, ssh_details)
    end
    @state.trigger(TaskStateLevels::COMPLETED)
  end



end