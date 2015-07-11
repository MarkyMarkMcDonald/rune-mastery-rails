require 'match_history_fetcher'
require 'match_summarizer'

class SearchController < ApplicationController

  def view
    @summoner_name = summoner_name

    matches = match_history_fetcher.fetch(summoner_name, region)

    return if matches.empty?

    @matches = matches.map do |match|
      begin
        match_summarizer.summarize(match)
      rescue
        nil
      end
    end.compact
  end

  private
  def summoner_name
    params[:summoner_name]
  end

  def region
    params[:region]
  end

  def match_history_fetcher
    @match_history_fetcher ||= MatchHistoryFetcher.new
  end

  def match_summarizer
    @match_summarizer ||= MatchSummarizer.new
  end
end
