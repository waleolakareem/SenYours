# Load the Rails application.
require_relative 'application'
require 'dotenv'
Dotenv.load
require "attr_encrypted"

# Initialize the Rails application.
Rails.application.initialize!
