require 'match_history_fetcher'
require 'match_summarizer'

class SearchController < ApplicationController

  def view
    @summoner_name = summoner_name

    matches = match_history_fetcher.fetch(summoner_name)

    @matches = matches.map do |match|
      match_summarizer.summarize(match)
    end
  end

  private
  def summoner_name
    params[:summoner_name]
  end

  def match_history_fetcher
    @match_history_fetcher ||= MatchHistoryFetcher.new
  end

  def match_summarizer
    @match_summarizer ||= MatchSummarizer.new
  end
end
