require_relative 'lib/task_orchestrator'

json = JSON.parse(File.read("../deployment_modules/rss_reader.json"))
task = TaskOrchestrator.new(json)
task.process