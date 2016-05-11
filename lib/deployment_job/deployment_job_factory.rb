require 'fileutils'
require_relative '../../lib/logging'
require_relative '../../lib/configuration'
require_relative '../../lib/common/local_file_system_helpers'
require_relative '../../lib/deployment_job/copy_local_files'
require_relative '../../lib/deployment_job/deploy_remote_files'
require_relative '../../lib/deployment_job/retrieve_remote_files'
require_relative '../../lib/deployment_job/install_tomcat_war'
require_relative '../../lib/task_module'

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

  def self.retrieve_http_remote_file
    retrieve_remote_file = RetrieveRemoteFiles.new(TaskModuleHelper.get_task_module[DeploymentJobConstants::RETRIEVE_REMOTE_FILE])
    retrieve_remote_file.process
  end

  def self.install_tomcat_war
    install_war_for_tomcat = InstallTomcatWar.new(TaskModuleHelper.get_task_module[DeploymentJobConstants::INSTALL_WAR_FOR_TOMCAT])
    install_war_for_tomcat.process
  end

end

class DeploymentJobConstants
  COPY_LOCAL_FILES = 'copy_local_files'
  DEPLOY_REMOTE_FILES = 'deploy_remote_files'
  INSTALL_WAR_FOR_TOMCAT = 'install_tomcat_war'
  RETRIEVE_REMOTE_FILE = 'retrieve_http_remote_file'
end