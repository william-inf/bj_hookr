require_relative '../../lib/state/state'
require_relative 'task_state_levels'


class TaskCompleteState < State

  def next(state)
    p "No further action."
  end

  def valid?(state)
    p "No further action."
  end

  def get_current_state
    TaskStateLevels::COMPLETED
  end

end