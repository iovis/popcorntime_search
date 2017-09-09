module PopcorntimeSearch
  class MovieResult
    attr_accessor :title, :year, :imdb

    def initialize(result)
      @title = result['title']
      @year  = result['year']
      @imdb  = result['imdb_id']
    end

    def to_s
      "#{title} (#{year})"
    end
  end
end
