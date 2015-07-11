require 'lol_api_config.rb'
require 'successful_games_scraper.rb'
require 'rune_comparator.rb'
require 'champion_fetcher.rb'
require 'rune_lookup.rb'
require 'json'

class MatchSummarizer
  def summarize(match)
    champion_id = match['participants'].first['championId']
    champion = champion_fetcher.fetch(champion_id)
    champion_name = champion['key']

    player_runes = match['participants'].first['runes'].map do |rune|
      {
        rune['runeId'].to_s => rune['rank']
      }
    end.reduce(&:merge)

    pro_games = JSON.parse($redis.get(champion_name))

    comparisons = pro_games.map do |pro_game|
      rune_choices = RuneComparator.contrast(pro_runes: pro_game['runes'], player_runes: player_runes).map do |rune_id, difference|
        {
            rune: RuneLookup.by_id(rune_id),
            difference: difference
        }
      end

      Contrast.new(pro_game['player_name'], rune_choices)
    end

    {
      comparisons: comparisons,
      champion_name: champion['name'],
    }
  end

  def champion_fetcher
    @champion_fetcher ||= ChampionFetcher.new
  end

  private
  def games_scraper
    @games_scraper ||= SuccessfulGamesScraper.new
  end
end
