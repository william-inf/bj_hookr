require_relative '../../lib/logging'
require_relative '../../lib/state/task_open_state'
require_relative '../../lib/logging'

class JobTemplate
  include TaskStateLevels
  include Logging

  attr_reader :state, :name

  def initialize(name, config)
    @name = name
    @config = config
    @state = TaskOpenState.new
  end

  def process
    raise "You must define #{caller[0][/`.*'/][1..-2]}.process()"
  end

end