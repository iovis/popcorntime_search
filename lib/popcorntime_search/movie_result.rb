require 'httparty'

module PopcorntimeSearch
  class MovieResult
    include HTTParty
    base_uri "#{BASE_URL}/movie/"

    attr_accessor :title, :year, :imdb

    def initialize(result)
      @title = result['title']
      @year  = result['year']
      @imdb  = result['imdb_id']
    end

    def to_s
      "#{title} (#{year})"
    end

    def links
      @links ||= build_links
    end

    private

    def build_links
      self.class.get("/#{@imdb}")['torrents'].each_with_object([]) do |(language, links), links_list|
        links.each do |quality, info|
          links_list << Link.new(title: @title,
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
