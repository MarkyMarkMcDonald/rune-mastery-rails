require 'lol_api_config.rb'
require 'rest_client'
require 'json'
require 'uri'

class MatchHistoryFetcher
  def fetch(summoner_name, region)
    summoner_name = summoner_name.downcase.delete(' ')

    begin
      summoner_id_endpoint = "#{LolApiConfig.base_url(region)}/api/lol/#{region}/v1.4/summoner/by-name/#{URI.escape(summoner_name)}?api_key=#{ENV['LOL_API_KEY']}"
      summoner_id_response = RestClient.get(summoner_id_endpoint)
      summoner_id = JSON.parse(summoner_id_response)[summoner_name]['id']

      match_history_endpoint = "#{LolApiConfig.base_url(region)}/api/lol/#{region}/v2.2/matchhistory/#{summoner_id}?api_key=#{ENV['LOL_API_KEY']}"
      match_history_response = RestClient.get(match_history_endpoint)
    rescue RestClient::Exception
      return []
    end

    JSON.parse(match_history_response)['matches']
  end
end
