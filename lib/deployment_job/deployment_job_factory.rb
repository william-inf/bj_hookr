require 'fileutils'
require_relative '../../lib/logging'
require_relative '../../lib/configuration'
require_relative '../../lib/common/local_file_system_helpers'
require_relative '../../lib/common/job_template'
require_relative '../../lib/task_module'
require_relative '../../lib/common/exceptions'
Dir[File.dirname(__FILE__)+ '/*.rb'].each {|file| require_relative file }

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
      raise UnhandledTaskType.new("Cannot find [#{name}] as a DeploymentJob. We only have #{@job_hash.inspect} registered.")
    end
  end

  private

  def create_job_hash
    #Retrieve every class that implements JobTemplate in the object space and load it.
    list = ObjectSpace.each_object(Class).select do |klass|
      klass < JobTemplate
    end

    list.each do |task_class|
      task_instance = task_class.new
      @job_hash[task_instance.name] = task_instance
    end

  end

end
