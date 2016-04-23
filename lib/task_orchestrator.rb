require 'json'
require_relative 'deployment'
require_relative 'deployment_job_factory'
require_relative '../lib/task_module'

class TaskOrchestrator
  include

  def initialize(task_module)
    @task_module = task_module
  end

  def process
    @task_module.keys.each do |job|
      factory = Object.const_get("#{job.capitalize}JobFactory")
      job_clazz = Object.const_get(job.capitalize).new(factory)

      TaskModule.instance.load_task_module(@task_module[job])

      @task_module[job].keys.each do |task|
        job_clazz.set_up(task)
      end
      job_clazz.process
    end
  end

end

json = JSON.parse(File.read('../modules/deployment_module.json'))
task = TaskOrchestrator.new(json)
task.process

