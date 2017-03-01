require_relative '../../lib/common/job_template'
require_relative '../../lib/common/remote_file_system_helpers'
require_relative '../../lib/common/local_file_system_helpers'

class RssReader < JobTemplate

  def initialize
    super(:rss_reader)
  end

  def process_task(config)
    config.keys.each do |key|
      validate_config(config[key], %w(local_path remote_path host user))
      logger.debug "Retrieving RSS Feed for [#{key}]"
      url = config[key]['url']


    end
  end

end