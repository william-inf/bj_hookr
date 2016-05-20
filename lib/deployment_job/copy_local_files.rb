require_relative '../../lib/common/job_template'
require_relative '../../lib/common/local_file_system_helpers'
require_relative '../../lib/common/exceptions'

class CopyLocalFiles < JobTemplate

  JOB_NAME = 'copy_local_files'

  def initialize
    super(JOB_NAME)
  end

  def process
    config = TaskModuleHelper.get_task_module[@name]
    super do
      config.keys.each do |key|
        validate_config(config[key], %w(from_dir to_dir))

        from_dir = config[key]['from_dir']
        to_dir = config[key]['to_dir']

        logger.debug "Copying files from #{from_dir} to #{to_dir}"

        LocalFileSystemHelpers.get_files(from_dir).each do |file|
          LocalFileSystemHelpers.copy_file(file, to_dir)
        end
      end
    end
  end

end

