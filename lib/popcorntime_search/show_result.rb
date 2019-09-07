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
      @episode ? build_episode_links : build_season_links
    end

    def build_episode_links
      episode_links = self.class.get("/#{@imdb_id}")['episodes'].find do |episode|
        episode['season'] == @season && episode['episode'] == @episode
      end

      return [] unless episode_links

      episode_links['torrents'].each_with_object([]) do |(quality, info), links_list|
        links_list << Link.new(title: "#{@title} #{@season}x#{@episode.to_s.rjust(2, '0')}",
                               imdb_id: imdb_id,
                               magnet: info['url'],
                               seeders: info['seeds'],
                               leechers: info['peers'],
                               language: 'en',
                               quality: quality,
                               provider: info['provider'])
      end
    end

    def build_season_links
      season_links = self.class.get("/#{@imdb_id}")['episodes'].select do |episode|
        episode['season'] == @season
      end

      return [] unless season_links

      season_links.each_with_object([]) do |episode_info, links_list|
        episode = episode_info['episode']

        quality, info = episode_info['torrents'].max_by { |quality, _| quality.to_i }

        links_list << Link.new(title: "#{@title} #{@season}x#{episode.to_s.rjust(2, '0')}",
                               imdb_id: imdb_id,
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
