module PopcorntimeSearch
  class ShowResult < MovieResult
    base_uri "#{BASE_URL}/show/"

    attr_accessor :title, :year, :imdb, :season, :episode

    def initialize(result, season, episode)
      super(result)

      @season  = season
      @episode = episode
    end

    private

    def build_links
      episode = self.class.get("/#{@imdb}")['episodes'].find do |episode|
        episode['season'] == @season && episode['episode'] == @episode
      end

      links_list = []

      episode['torrents'].each do |quality, info|
        next if quality == '0'
        links_list << Link.new(title: "#{@title} #{@season}x#{@episode.to_s.rjust(2, '0')}",
                               magnet: info['url'],
                               seeders: info['seeds'],
                               leechers: info['peers'],
                               language: 'en',
                               quality: quality,
                               provider: info['provider'])
      end

      links_list
    end
  end
end
