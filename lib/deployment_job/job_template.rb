require_relative '../../lib/logging'
require_relative '../../lib/state/task_open_state'

class JobTemplate
  include TaskStateLevels

  attr_reader :state, :name

  def initialize(name)
    @name = name
    @state = TaskOpenState.new
  end

  def process
    raise "You must define #{caller[0][/`.*'/][1..-2]}.process()"
  end

end