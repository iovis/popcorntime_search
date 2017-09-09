module PopcorntimeSearch
  class Search
    attr_accessor :title, :season, :episode

    def initialize(search)
      @title   = search[SHOWNAME_REGEXP, :showname].strip
      @season  = search[SEASON_EPISODE_REGEXP, :season].to_i
      @episode = search[SEASON_EPISODE_REGEXP, :episode].to_i
    end
  end
end
