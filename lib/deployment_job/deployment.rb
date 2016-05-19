require_relative '../../lib/deployment_job/deployment_job_factory'
require_relative '../../lib/logging'

class Deployment
  include Logging

  attr_reader :jobs

  def initialize(factory)
    @jobs = []
    @factory = factory
  end

  def set_up(task)
    register_job(@factory.get_task_processor_for_name(task))
  end

  def process
    @jobs.each_with_index do |job, idx|
      logger.info "#{idx + 1} - Beginning processing for deployment job: #{job}"
      job.process
      logger.info "Job: #{job} completed."
    end
    logger.info 'Deployment job tasks all complete.'
  end

  def register_job(job)
    @jobs << job
  end

end


