class Task < CDQManagedObject
  STATUS = [
    CANCLE = -1,
    FINISH = 0,
    START = 1,
    PENDING = 2,
  ]

  def self.start(title)
    create(title: title, started_at: Time.now, status: START)
  end

  def finish
    self.status = FINISH
    self.finished_at = Time.now
  end

  def elapsed_time
    second = -self.started_at.timeIntervalSinceNow
    "%02d:%02d:%02d" % [second / 3600, second / 60 % 60, second % 60]
  end

  def display
    "[#{title} / #{elapsed_time}]"
  end
end
