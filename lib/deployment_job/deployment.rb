require_relative '../../lib/deployment_job/deployment_job_factory'
require_relative '../../lib/logging'

class Deployment
  include Logging

  attr_reader :jobs

  def initialize(factory)
    @jobs = []
    @factory = factory
  end

  def set_up(job)
    register_job(@factory.method(job.to_sym))
  end

  def process
    @jobs.each do |job|
      job.call
    end
  end

  def register_job(job)
    @jobs << job
  end

end


