require_relative 'task_complete_state'
require_relative 'task_state_levels'
require_relative '../../lib/logging'

class TaskInProcessingState < State
  include Logging

  def next(state)
    logger.debug("Changing state to #{TaskStateLevels::COMPLETED}")
    TaskCompleteState.new if valid?(state)
  end

  def valid?(state)
    state == TaskStateLevels::COMPLETED
  end

  def get_current_state
    TaskStateLevels::COMPLETED
  end

end