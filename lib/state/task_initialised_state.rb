require_relative 'task_state_levels'
require_relative 'task_in_processing_state'
require_relative 'state'
require_relative '../../lib/logging'

class TaskInitialisedState < State
  include Logging

  def next(state)
    if valid?(state)
      logger.debug("Changing state to #{TaskStateLevels::PROCESSING}")
      TaskInProcessingState.new
    else
      raise 'Illegal State Jump'
    end
  end

  def valid?(state)
    state == TaskStateLevels::PROCESSING
  end

  def get_current_state
    TaskStateLevels::PROCESSING
  end

end