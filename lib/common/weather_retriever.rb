require 'httparty'
require_relative '../../lib/logging'

class WeatherResult

  attr_accessor :temperature, :description, :pressure, :humidity, :temp_min, :temp_max, :wind_speed, :wind_direction, :sunrise, :sunset

end

class WeatherRetriever
  include Logging

  def initialize(api_key, unit = 'metric')
    @base_uri = 'http://api.openweathermap.org/data/2.5'
    @api_key = api_key
    @unit = unit
  end

  def get_location_weather(location, country = nil)
    response = make_api_request(location, country)
    result = WeatherResult.new
    result.description = response['weather'][0]['description']
    result.temperature = response['main']['temp']
    result.pressure = response['main']['pressure']
    result.humidity = response['main']['humidity']
    result.temp_max = response['main']['temp_max']
    result.temp_min = response['main']['temp_min']
    result.wind_speed = response['wind']['speed']
    result.wind_direction = response['wind']['deg']
    result.sunrise = response['sys']['sunrise']
    result.sunset = response['sys']['sunset']
    result
  end

  def make_api_request(location, country)
    HTTParty.get(@base_uri + "/weather?q=#{location},#{country}&appid=#{@api_key}&units=#{@unit}")
  end

end
