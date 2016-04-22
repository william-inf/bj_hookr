require_relative '../../lib/deployment_job/job_template'
require_relative '../../lib/common/local_file_system_helpers'
require_relative '../state/task_state_levels'

class CopyLocalFiles < JobTemplate

  def initialize(config)
    super('CopyLocalFiles', config)
  end

  def process
    @state.trigger(TaskStateLevels::PROCESSING)
    @config.keys.each do |key|
      logger.debug "Beginning copy task [#{key}]"

      from_dir = @config[key]['from_dir']
      to_dir = @config[key]['to_dir']

      logger.debug "Copying files from #{from_dir} to #{to_dir}"

      LocalFileSystemHelpers.get_files(from_dir).each do |file|
        LocalFileSystemHelpers.copy_file(file, to_dir)
      end
    end
    @state.trigger(TaskStateLevels::COMPLETED)
  end



end