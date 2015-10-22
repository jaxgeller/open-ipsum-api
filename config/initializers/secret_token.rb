# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.

# Although this is not needed for an api-only application, rails4
# requires secret_key_base or secret_token to be defined, otherwise an
# error is raised.
# Using secret_token for rails3 compatibility. Change to secret_key_base
# to avoid deprecation warning.
# Can be safely removed in a rails3 api-only application.
OpenipsumApiV2::Application.config.secret_token = '35ed5fc676e46c6540eb9882c86ec9998c18ff9c5bb3559d10caabda2e5020337b52610bac141200e43cf2b5918bdf4f6bf37be4d78ad137e427df114d438bb2'
