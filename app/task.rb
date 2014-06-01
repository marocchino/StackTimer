class Task
  STATUS = [
    CANCLE = -1,
    FINISH = 0,
    START = 1,
    PENDING = 2,
  ]
  attr_accessor :title, :started_at, :status
  def initialize(title)
    @title = title
    @started_at = Time.now
    @status = START
  end

  def finish
    @status = FINISH
  end

  def elapsed_time
    second = -@started_at.timeIntervalSinceNow
    "%02d:%02d:%02d" % [second / 3600, second / 60 % 60, second % 60]
  end

  def display
    "[#{title} / #{elapsed_time}]"
  end
end
