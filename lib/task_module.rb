require 'singleton'
require 'json'

class TaskModule
  include Singleton

  attr_accessor :task_module

  def load_task_module(task_module_config)
    @task_module = task_module_config
  end

  def get_task_module
    @task_module
  end
end

module TaskModuleHelper

  def self.get_task_module
    TaskModule.instance.get_task_module
  end

end
