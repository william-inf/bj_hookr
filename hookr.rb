require_relative 'lib/task_orchestrator'

json = JSON.parse(File.read('../modules/deployment_module_example.json'))
task = TaskOrchestrator.new(json)
task.process