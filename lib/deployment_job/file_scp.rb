require_relative '../../lib/deployment_job/job_template'

class FileSCP < JobTemplate

  def initialize(file, directory)
    super('FileSCP')
    @file = file
    @directory = directory
  end

  def set_up

  end

  def process
    # Check if file exists, if it does, get hash, if same, don't copy, else copy.
  end



end