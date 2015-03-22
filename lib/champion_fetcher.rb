require 'rest_client'
require 'json'

class ChampionFetcher
  def fetch(champion_id)
    champion_info_endpoint = "#{Rails.configuration.lol_api_base_url}/api/lol/static-data/#{Rails.configuration.lol_api_region}/v1.2/champion/#{champion_id}?api_key=#{Rails.configuration.lol_api_key}"
    champion_info_response = RestClient.get(champion_info_endpoint)
    JSON.parse(champion_info_response)
  end

end
