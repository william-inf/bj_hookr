require 'fileutils'
require_relative '../lib/deployment_job/file_scp'
require_relative '../lib/logging'
require_relative '../lib/configuration'
require_relative 'common/local_file_system_helpers'

class DeploymentJobFactory
  include Logging
  include ConfigHelper

  def copy_local_files
    from_dir = ConfigHelper.get_config('from_dir', 'copy_files')
    to_dir = ConfigHelper.get_config('to_dir', 'copy_files')

    logger.debug "Copying files from #{from_dir} to #{to_dir}"

    LocalFileSystemHelpers.get_files(from_dir).each do |file|
      LocalFileSystemHelpers.copy_file(file, to_dir)
    end

    logger.debug 'Copy files complete'
  end

  def check_local_files
    logger.debug 'Here in local files'
  end

end