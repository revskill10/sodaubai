# This file is used by Rack-based servers to start the application.
require 'rack'
require 'rack/cache'
require 'redis-rack-cache'

use Rack::Cache,
metastore: 'redis://localhost:6381/1/metastore',
entitystore: 'redis://localhost:6381/1/entitystore'

require ::File.expand_path('../config/environment',  __FILE__)
run Trytest::Application
