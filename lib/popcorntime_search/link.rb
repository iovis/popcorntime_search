module PopcorntimeSearch
  class Link
    attr_accessor :filename, :size, :magnet, :seeders, :leechers, :language, :quality, :provider

    def initialize(filename:, size:, magnet:, seeders:, leechers:, language:, quality:, provider:)
      @filename = filename
      @size     = size
      @magnet   = magnet
      @seeders  = seeders
      @leechers = leechers
      @language = language
      @quality  = quality
      @provider = provider
    end

    def <=>(other)
      @seeders <=> other.seeders
    end

    def to_s
      "#{@filename} [#{@quality}][#{@language.upcase}][#{@provider}] (#{@size}) - [#{@seeders.to_s.green}/#{@leechers.to_s.red}]"
    end

    def info_hash
      @info_hash ||= extract_hash
    end

    private

    def extract_hash
      # Extract magnet properties to a Hash and then parse the sha1 info hash
      raw_hash = @magnet[/(xt.*?)&/, 1]  # extract the xt property
      raw_hash.split(':').last.downcase
    end
  end
end
