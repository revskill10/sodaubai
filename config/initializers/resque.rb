#require 'resque_scheduler'
Dir[File.join(Rails.root, 'app', 'workers', '*.rb')].each { |file| require file }
#config = YAML::load(File.open("#{Rails.root}/config/redis.yml"))[Rails.env]
Resque.redis = Redis.new(:host => "localhost", :port => "6777")
Resque.schedule = YAML.load_file(Rails.root.join('config', 'resque_schedule.yml'))
