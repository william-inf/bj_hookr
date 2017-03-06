require_relative '../../lib/common/job_template'
require_relative '../../lib/common/rss_feed_reader'

class RssReader < JobTemplate

  def initialize
    super(:rss_reader)
  end

  def process_task(config)
    config.keys.each do |key|
      validate_config(config[key], %w(url rss_str count))
      logger.debug "Retrieving RSS Feed for [#{key}]"

      url = config[key]['url']
      rss_str = config[key]['rss_str']
      count = config[key]['count'].to_i
      export = config[key]['export']

      reader = RssFeedReader.new(url, rss_str, count)
      reader.process

      case export
        when 'STDOUT'
          reader.content.each { |r| $stdout.write r }
        else
          reader.content.each { |r| $stdout.write r }
      end

    end
  end

end