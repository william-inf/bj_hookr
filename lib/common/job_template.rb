require_relative '../../lib/logging'
require_relative '../../lib/logging'
require_relative '../../lib/common/exceptions'

class JobTemplate
  include Logging

  attr_reader :name

  def initialize(name, config)
    @name = name
    @config = config
  end

  def process
    begin
      yield if block_given?
    rescue HookrJobError => e
      logger.error "Error hit in #{caller[0][/`.*'/][1..-2]}.process(), ERROR: [#{e.message}]"
      raise e
    end
  end

  def validate_config(config, key_list)
    key_list.each do |key|
      raise HookrInvalidConfigError.new "Config missing key: [#{key}]" unless config.has_key? key
    end
  end

end
