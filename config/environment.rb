# Load the rails application
require File.expand_path('../application', __FILE__)
ENV['RAILS_ENV'] ||= 'production'

#Rails.logger = Logger.new(STDOUT)
# Initialize the rails application
Trytest::Application.initialize!
