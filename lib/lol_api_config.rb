module LolApiConfig
  LOL_API_GLOBAL_BASE_URL = 'https://global.api.pvp.net'
  LOL_API_REGION = 'na'

  def self.base_url(region)
    "https://#{region}.api.pvp.net"
  end

end
