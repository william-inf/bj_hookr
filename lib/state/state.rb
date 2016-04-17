class State
  def next(state)
    raise "You must define #{caller[0][/`.*'/][1..-2]}.next()"
  end

  def valid?(state)
    raise "You must define #{caller[0][/`.*'/][1..-2]}.valid?()"
  end

  def get_current_state
    raise "You must define #{self.class}.get_current_state()"
  end
end