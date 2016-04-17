require_relative '../lib/deployment_job/file_scp'
require_relative '../lib/logging'
require_relative '../lib/configuration'

class DeploymentJobFactory
  include Logging
  include ConfigHelper

  def copy_files(file)
    #FileSCP.new(file, directory)
    logger.debug 'Here in create file' + file
  end

  def connect_to_machine
    logger.debug 'Here in connect'
  end

  def check_local_files
    logger.debug 'Here in local files'
  end

end