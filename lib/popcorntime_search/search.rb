require 'httparty'

module PopcorntimeSearch
  class Search
    include HTTParty
    base_uri 'https://tv-v2.api-fetch.website'.freeze

    attr_accessor :title, :season, :episode, :kind

    def initialize(search)
      @title   = search[TITLE_REGEXP, :showname].strip

      season   = search[SEASON_EPISODE_REGEXP, :season]
      episode  = search[SEASON_EPISODE_REGEXP, :episode]
      @season  = season.to_i if season
      @episode = episode.to_i if episode

      @kind = @season && @episode ? :show : :movie
    end

    def results
      @results ||= self.class.get("/#{@kind}s/1", query: { keywords: @title })
    end

    def results_found?
      @results_found ||= results.count > 0
    rescue SocketError
      @results_found = false
    end
  end
end
