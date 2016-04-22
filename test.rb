require_relative 'lib/state/task_open_state'
require_relative 'lib/state/task_state_levels'
require_relative 'lib/deployment_job_factory'
require_relative 'lib/deployment'
require_relative 'lib/configuration'

include Logging

Configuration.instance.load_config('../../config/deployment_config.json')

deployment = Deployment.new(DeploymentJobFactory.new)
deployment.set_up
deployment.process






