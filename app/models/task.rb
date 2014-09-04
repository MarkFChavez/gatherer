class Task
  attr_accessor :size, :completed

  def initialize(options = {})
    mark_completed(options[:completed]) if options[:completed]
    @size = options[:size]
  end

  def complete?
    !@completed_at.nil?
  end

  def mark_completed(date = nil)
    @completed_at = (date || Time.current)
  end

  def counts_toward_velocity?
    return false unless complete?
    @completed_at > 3.weeks.ago
  end

  def points_toward_velocity
    if counts_toward_velocity? then size else 0 end
  end
end
