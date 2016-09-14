require_relative '../../lib/common/job_template'
require_relative '../../lib/common/local_file_system_helpers'
require_relative '../../lib/common/exceptions'

class CopyLocalFiles < JobTemplate

  def initialize
    super(:copy_local_files)
  end

  def process_task(config)
    config.keys.each do |key|
      validate_config(config[key], %w(from_dir to_dir))

      from_dir = config[key].fetch('from_dir')
      to_dir = config[key].fetch('to_dir')

      logger.debug "Copying files from #{from_dir} to #{to_dir}"

      LocalFileSystemHelpers.get_files(from_dir).each do |file|
        unless file.nil?
          LocalFileSystemHelpers.copy_file(file, to_dir)
        end
      end
    end
  end

end

