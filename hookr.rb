require_relative 'lib/task_orchestrator'

json = JSON.parse(File.read("file.json"))
task = TaskOrchestrator.new(json)
task.process