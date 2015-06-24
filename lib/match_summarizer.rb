require 'lol_api_config.rb'
require 'successful_games_scraper.rb'
require 'rune_comparator.rb'
require 'champion_fetcher.rb'
require 'rune_lookup.rb'

class MatchSummarizer
  def summarize(match)
    champion_id = match['participants'].first['championId']
    champion = ChampionFetcher.new.fetch(champion_id)
    champion_name = champion['name']

    player_runes = match['participants'].first['runes'].map do |rune|
      {
        rune['runeId'].to_s => rune['rank']
      }
    end.reduce(&:merge)

    pro_games = games_scraper.games(champion_name)

    comparisons = pro_games.map do |pro_game|
      pro_runes = pro_game[:rune_id_counts]

      contrast = RuneComparator.contrast(pro_runes: pro_runes, player_runes: player_runes).map do |rune_id, difference|
        {
            rune: RuneLookup.by_id(rune_id),
            difference: difference
        }
      end

      {
        player_runes: player_runes,
        pro_name: pro_game[:player_name],
        contrast: contrast
      }
    end

    {
      comparisons: comparisons,
      champion_name: champion_name,
    }
  end

  private
  def games_scraper
    @games_scraper ||= SuccessfulGamesScraper.new
  end
end
