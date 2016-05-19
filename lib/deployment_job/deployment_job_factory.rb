require 'fileutils'
require_relative '../../lib/logging'
require_relative '../../lib/configuration'
require_relative '../../lib/common/local_file_system_helpers'
require_relative '../../lib/deployment_job/copy_local_files'
require_relative '../../lib/deployment_job/deploy_remote_files'
require_relative '../../lib/deployment_job/retrieve_remote_files'
require_relative '../../lib/deployment_job/ssh_session'
require_relative '../../lib/task_module'
require_relative '../../lib/common/exceptions'

class DeploymentJobFactory
  include Logging
  include ConfigHelper
  include TaskModuleHelper

  def initialize
    @job_hash = {}
    create_job_hash
  end

  def get_task_processor_for_name(name)
    if @job_hash.has_key? name
      @job_hash[name]
    else
      raise UnhandledTaskType.new("Cannot find [#{name}] as a DeploymentJob.")
    end
  end

  private

  def create_job_hash
    list = ObjectSpace.each_object(Class).select do |klass|
      klass < JobTemplate
    end

    list.each do |task_class|
      task_instance = task_class.new
      @job_hash[task_instance.name] = task_instance
    end

  end

end
