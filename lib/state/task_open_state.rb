require_relative 'task_initialised_state'
require_relative 'task_state_levels'

class TaskOpenState
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