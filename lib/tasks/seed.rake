namespace :seed do
  desc 'Seed the database with professional games for each champion'
  task pro_games: :environment do
    ProGameScraper.new.execute
  end
end
