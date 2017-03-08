require_relative '../../lib/common/job_template'
require_relative '../../lib/common/weather_retriever'

class Weather < JobTemplate

  def initialize
    super(:weather)
  end

  def process_task(config)
    config.keys.each do |key|
      validate_config(config[key], %w(api_key location country))
      logger.debug "Retrieving Weather for [#{key}]"
      api_key = config[key]['api_key']
      location = config[key]['location']
      country = config[key]['country']

      weather_retriever = WeatherRetriever.new(api_key)
      result = weather_retriever.get_location_weather(location, country)
      logger.info "Current Weather: #{result.description} - #{result.temperature} deg C"
      logger.debug result.inspect
      # make this much nicer..
    end
  end

end

