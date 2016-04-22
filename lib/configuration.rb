require 'singleton'
require 'json'

class Configuration
  include Singleton

  attr_accessor :config

  def load_config(file)
    @config = JSON.parse(File.read(file))
  end

  def get_config(key, node = nil)
    if @config.nil?
      raise 'You have not initialised config yet.'
    elsif node
      @config[node][key]
    else
      @config[key]
    end
  end
end

module ConfigHelper

  def self.get_config(key, node = nil)
    Configuration.instance.get_config(key, node)
  end

end
