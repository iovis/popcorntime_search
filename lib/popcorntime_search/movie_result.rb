require 'httparty'

module PopcorntimeSearch
  class MovieResult
    include HTTParty
    base_uri "#{BASE_URL}/movie/"

    attr_accessor :title, :year, :imdb_id
    attr_reader :kind

    def initialize(result)
      @title   = result['title']
      @year    = result['year']
      @imdb_id = result['imdb_id']
      @kind    = :movie
    end

    def to_s
      "#{title} (#{year})"
    end

    def links
      @links ||= build_links
    end

    private

    def build_links
      self.class.get("/#{@imdb_id}")['torrents'].each_with_object([]) do |(language, links), links_list|
        links.each do |quality, info|
          links_list << Link.new(title: @title,
                                 imdb_id: imdb_id,
                                 size: info['filesize'],
                                 magnet: info['url'],
                                 seeders: info['seed'],
                                 leechers: info['peer'],
                                 language: language,
                                 quality: quality,
                                 provider: info['provider'])
        end
      end
    end
  end
end
