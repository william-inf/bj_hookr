require 'artii'
require_relative 'lib/task_orchestrator'

# hooker_module = 'exchange-services-deployment-bxtt'
# hooker_module = 'exchange-services-deployment-bxpp'
# hooker_module = 'exchange-services-deployment-bxdv'
# hooker_module = 'billing-frontend-deployment-bxdv'
hooker_module = 'billing-frontend-deployment-bxtt'


json = JSON.parse(File.read("../deployment_modules/#{hooker_module}.json"))
task = TaskOrchestrator.new(json)
task.process