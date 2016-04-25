require_relative 'task_initialised_state'
require_relative 'task_state_levels'
require_relative '../logging'

# Initial class, this is the state object. Right now, it does fuck all.
# It needs to control the state of a process, but at this point it isn't
# necessary for standard logic being used. I doubt I'll need it.

class TaskOpenState
  include Logging
  attr_reader :state

  def initialize
    @state = TaskInitialisedState.new
  end

  def previous(state)
    @state = @state.previous(state)
  end

  def trigger(state)
    @state = @state.next(state)
  end

  def get_current_state
    TaskStateLevels::INITIALISED
  end

end