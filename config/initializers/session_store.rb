# Be sure to restart your server when you modify this file.

Trytest::Application.config.session_store :redis_store, :servers => "redis://127.0.0.1:6999/10"

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
# Trytest::Application.config.session_store :active_record_store
