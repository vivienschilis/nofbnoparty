# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_jjpippo_session',
  :secret      => 'efd9de46c989d5dbde54b22774dda0f42aa516ee845729ce225c138427a979faef97f1455e500bd9fdb3fdd6f3df0bae26069fff4ccf078d961d7ee98cf766d9'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
