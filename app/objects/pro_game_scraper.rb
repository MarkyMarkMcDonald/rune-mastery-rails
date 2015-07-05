require 'lol_api_config'
require 'successful_games_scraper'
require 'json'
require 'rest_client'

class ProGameScraper
  def execute
    champion_names = JSON.parse(RestClient.get(champion_endpoint))['data'].map {|name| name.first}
    champion_names.each do |champion_name|
      games = successful_games_scraper.games(champion_name)
      games.each do |game|
        ProGame.create(champion_name: champion_name, player_name: game[:player_name], runes: game[:rune_id_counts])
      end
    end
  end

  private
  def successful_games_scraper
    SuccessfulGamesScraper.new
  end

  def champion_endpoint
    "#{LolApiConfig::LOL_API_BASE_URL}/api/lol/static-data/#{LolApiConfig::LOL_API_REGION}/v1.2/champion?api_key=#{ENV['LOL_API_KEY']}"
  end
end