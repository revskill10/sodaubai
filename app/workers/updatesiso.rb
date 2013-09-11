module UpdateSisoJob
  @queue = :schedule_queue
  def self.perform()
    # Do anything here, like access models, etc
    puts "Doing my job"
  end
end