# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_widz_project_session',
  :secret      => '17b8bc72f6fc8402a2a64a349ee26d5db8520268b4b7a386df87f84ead53b8a7f8c900dd0d71c218ec5eee303e2aa6d2a5651bd71a4b364dafd012d3664e81b3'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
