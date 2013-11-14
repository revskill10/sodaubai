require 'rake'
require 'queue_classic'
require 'queue_classic/tasks'
ENV["DATABASE_URL"] = "postgres://queue:123456@localhost/queue_classic"

