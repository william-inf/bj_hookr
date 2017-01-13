require 'json'
require_relative '../lib/deployment_job/deployment'
require_relative '../lib/deployment_job/deployment_job_factory'
require_relative '../lib/task_module'
require_relative '../lib/logging'

class TaskOrchestrator
  include Logging

  def initialize(task_module)
    @task_module = task_module
  end

  def process
    @task_module.keys.each do |job|
      factory_class = Object.const_get("#{job.capitalize}JobFactory")
      factory = factory_class.new
      job_clazz = Object.const_get(job.capitalize).new(factory)

      TaskModule.instance.load_task_module(@task_module[job])

      @task_module[job].keys.each do |task|
        job_clazz.set_up(task.to_sym)
      end

      job_clazz.process
    end

  rescue StandardError => e
    logger.error("Task unsuccessful and unable to complete due to '#{e.message}'")
  end

end


