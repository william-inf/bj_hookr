
require_relative 'lib/task_orchestrator'

# hooker_module = 'harvester-deployment-bxdv'
hooker_module = 'test_module'


json = JSON.parse(File.read("modules/#{hooker_module}.json"))
task = TaskOrchestrator.new(json)
task.process