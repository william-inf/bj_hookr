require 'artii'
require_relative 'lib/task_orchestrator'

hooker_module = ''
json = JSON.parse(File.read("../deployment_modules/#{hooker_module}.json"))
task = TaskOrchestrator.new(json)
task.process