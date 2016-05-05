require 'artii'

require_relative 'lib/task_orchestrator'

a = Artii::Base.new :font => 'banner'
puts a.asciify('bj_hookr')

hookr_module = 'deployment_module'
json = JSON.parse(File.read("modules/#{hookr_module}.json"))
task = TaskOrchestrator.new(json)
task.process