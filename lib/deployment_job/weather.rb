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
      logger.debug "\n\n#{@a.asciify('Current Weather')}\n" +
          "#{colorize('Description', 'red')}: #{result.description}\n" +
          "#{colorize('Current Temperature', 'red')}: #{result.temperature} (Min: #{result.temp_min} - Max: #{result.temp_max})\n" +
          "#{colorize('Humidity', 'red')}: #{result.humidity}\n" +
          "#{colorize('Wind Speed', 'red')}: #{result.wind_speed}\n" +
          "#{colorize('Wind Direction', 'red')}: #{result.wind_direction}\n" +
          "#{colorize('Sunrise', 'red')}: #{Time.at(result.sunrise)}\n\n"
          "#{colorize('Sunset', 'red')}: #{Time.at(result.sunset)}\n\n"
      # make this much nicer..
    end
  end

end
