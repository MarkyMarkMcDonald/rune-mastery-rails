require 'lol_api_config.rb'
require 'rest_client'
require 'json'

class ChampionFetcher
  def fetch(champion_id)
    @@champions ||= all_champions
    return @@champions[champion_id] if @@champions[champion_id]

    champion_info_endpoint = "#{LolApiConfig::LOL_API_GLOBAL_BASE_URL}/api/lol/static-data/#{LolApiConfig::LOL_API_REGION}/v1.2/champion/#{champion_id}?api_key=#{ENV['LOL_API_KEY']}"
    champion_info_response = RestClient.get(champion_info_endpoint)
    @@champions[champion_id] = JSON.parse(champion_info_response)
  end

  private
  def all_champions
    all_champions = JSON.parse(RestClient.get("#{LolApiConfig::LOL_API_GLOBAL_BASE_URL}/api/lol/static-data/#{LolApiConfig::LOL_API_REGION}/v1.2/champion?api_key=#{ENV['LOL_API_KEY']}"))
    all_champions['data'].reduce({}) do |champions, (_, champion)|
      champions[champion['id']] = champion
      champions
    end
  end

end
