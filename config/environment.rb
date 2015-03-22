


# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

# require 'dotenv'
#
# Dotenv.load '.env'

RuneMastery::Application.configure do
  config.lol_api_key = ENV['LOL_API_KEY']
  config.lol_api_region = 'na'
  config.lol_api_base_url = 'https://na.api.pvp.net'
end
