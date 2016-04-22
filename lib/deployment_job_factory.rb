require 'fileutils'
require_relative '../lib/logging'
require_relative '../lib/configuration'
require_relative 'common/local_file_system_helpers'
require_relative '../lib/deployment_job/copy_local_files'
require_relative '../lib/task_module'

class DeploymentJobFactory
  include Logging
  include ConfigHelper
  include TaskModuleHelper

  def self.copy_local_files
    file_copy_process = CopyLocalFiles.new(TaskModuleHelper.get_task_module)
    file_copy_process.process
  end

end