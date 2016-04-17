require 'singleton'
require 'json'

class Configuration
  include Singleton

  attr_accessor :config

  def load_config(file)
    @config = JSON.parse(File.read(file))
  end

  def get_config(key)
    if @config.nil?
      raise 'You have not initialised config yet.'
    else
      @config[key]
    end
  end
end

module ConfigHelper

  def get_config(key)
    Configuration.instance.get_config(key)
  end

end
