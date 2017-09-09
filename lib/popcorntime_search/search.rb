module PopcorntimeSearch
  class Search
    attr_accessor :title, :season, :episode, :kind

    def initialize(search)
      @title   = search[SHOWNAME_REGEXP, :showname].strip

      season   = search[SEASON_EPISODE_REGEXP, :season]
      episode  = search[SEASON_EPISODE_REGEXP, :episode]
      @season  = season.to_i if season
      @episode = episode.to_i if episode

      @kind = @season && @episode ? :show : :movie
    end
  end
end
