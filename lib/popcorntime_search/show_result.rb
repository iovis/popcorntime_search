module PopcorntimeSearch
  class ShowResult < MovieResult
    base_uri "#{BASE_URL}/show/"

    attr_accessor :season, :episode

    def initialize(result, season, episode)
      super(result)

      @kind    = :show
      @season  = season
      @episode = episode
    end

    private

    def build_links
      episode_links = self.class.get("/#{@imdb_id}")['episodes'].find do |episode|
        episode['season'] == @season && episode['episode'] == @episode
      end

      return [] unless episode_links

      episode_links['torrents'].each_with_object([]) do |(quality, info), links_list|
        next if quality == '0'
        links_list << Link.new(title: "#{@title} #{@season}x#{@episode.to_s.rjust(2, '0')}",
                               magnet: info['url'],
                               seeders: info['seeds'],
                               leechers: info['peers'],
                               language: 'en',
                               quality: quality,
                               provider: info['provider'])
      end
    end
  end
end
