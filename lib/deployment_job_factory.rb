require 'fileutils'
require_relative '../lib/logging'
require_relative '../lib/configuration'
require_relative 'common/local_file_system_helpers'
require_relative '../lib/deployment_job/copy_local_files'
require_relative '../lib/deployment_job/deploy_remote_files'

require_relative '../lib/task_module'

class DeploymentJobFactory
  include Logging
  include ConfigHelper
  include TaskModuleHelper

  def self.copy_local_files
    file_copy_process = CopyLocalFiles.new(TaskModuleHelper.get_task_module[DeploymentJobConstants::COPY_LOCAL_FILES])
    file_copy_process.process
  end

  def self.deploy_remote_files
    remote_file_process = DeployRemoteFiles.new(TaskModuleHelper.get_task_module[DeploymentJobConstants::DEPLOY_REMOTE_FILES])
    remote_file_process.process
  end

  def self.build_config
    # Place holder
    logger.debug 'Building config'
    p TaskModuleHelper.get_task_module[DeploymentJobConstants::BUILD_CONFIG]
  end

end

class DeploymentJobConstants
  COPY_LOCAL_FILES = 'copy_local_files'
  DEPLOY_REMOTE_FILES = 'deploy_remote_files'
  BUILD_CONFIG = 'build_config'

end