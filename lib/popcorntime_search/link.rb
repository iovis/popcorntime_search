require 'cgi'

module PopcorntimeSearch
  class Link
    attr_accessor :title, :size, :magnet, :seeders, :leechers, :language, :quality, :provider
    attr_writer :filename

    def initialize(title:, filename: nil, size: nil, magnet:, seeders:, leechers:, language:, quality:, provider:)
      @title    = title
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
      string = "#{title} [#{quality}][#{language.upcase}][#{provider}]"
      string << " (#{size})" if size
      string << " - [#{seeders.to_s.green}/#{leechers.to_s.red}]"
      string
    end

    def filename
      @filename ||= parsed_hash['dn'].first
    end

    def info_hash
      @info_hash ||= extract_info_hash
    end

    private

    def extract_info_hash
      # xt=urn:<hash_type>:<info_hash>
      parsed_hash['xt'].first.split(':').last.downcase
    end

    def parsed_hash
      @parsed_hash ||= CGI.parse(magnet.sub('magnet:?', ''))
    end
  end
end
