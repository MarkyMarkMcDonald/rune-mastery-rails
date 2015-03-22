require 'rest_client'
require 'json'
require 'uri'

class MatchHistoryFetcher
  def fetch(summoner_name)
    summoner_name = summoner_name.downcase.delete(' ')


    summoner_id_endpoint = "#{Rails.configuration.lol_api_base_url}/api/lol/#{Rails.configuration.lol_api_region}/v1.4/summoner/by-name/#{URI.escape(summoner_name)}?api_key=#{Rails.configuration.lol_api_key}"
    summoner_id_response = RestClient.get(summoner_id_endpoint)
    summoner_id = JSON.parse(summoner_id_response)[summoner_name]['id']

    match_history_endpoint = "#{Rails.configuration.lol_api_base_url}/api/lol/#{Rails.configuration.lol_api_region}/v2.2/matchhistory/#{summoner_id}?api_key=#{Rails.configuration.lol_api_key}"
    match_history_response = RestClient.get(match_history_endpoint)
    JSON.parse(match_history_response)['matches']
  end
end
