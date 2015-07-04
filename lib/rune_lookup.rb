require 'lol_api_config'
require 'rest_client'
require 'json'

class RuneLookup

  Rune = Struct.new(:id, :name, :type)

  def self.by_id(id)
    @@runes ||= self.all_runes
    return @@runes[id] if @@runes[id]

    api_key = ENV['LOL_API_KEY']
    region = 'na'
    base_url = 'https://na.api.pvp.net'

    rune_info_endpoint = "#{base_url}/api/lol/static-data/#{region}/v1.2/rune/#{id}?runeData=colloq,depth&api_key=#{api_key}"
    rune_info_response = RestClient.get(rune_info_endpoint)
    rune_info = JSON.parse(rune_info_response)

    @@runes[id] = Rune.new(id.to_i, rune_info['name'], rune_info['rune']['type'])
  end

  private
  def self.all_runes
    all_runes = JSON.parse(RestClient.get("#{LolApiConfig::LOL_API_BASE_URL}/api/lol/static-data/#{LolApiConfig::LOL_API_REGION}/v1.2/rune?runeListData=colloq,depth&api_key=#{ENV['LOL_API_KEY']}"))
    all_runes['data'].reduce({}) do |runes, (id, rune)|
      runes[id] = Rune.new(id.to_i, rune['name'], rune['rune']['type'])
      runes
    end
  end
end
