module PopcorntimeSearch
  class ShowResult < MovieResult
    attr_accessor :title, :year, :imdb, :season, :episode

    def initialize(result, season, episode)
      super(result)

      @season  = season
      @episode = episode
    end
  end
end
