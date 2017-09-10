FactoryGirl.define do
  factory :link, class: PopcorntimeSearch::Link do
    link {{
      title: 'The Godfather',
      size: '2.40 GB',
      magnet: 'magnet:?xt=urn:btih:5E915039C619366E490D08DB3FFED21F3A3AE84A&tr=udp://glotorrents.pw:6969/announce&tr=udp://tracker.opentrackr.org:1337/announce&tr=udp://torrent.gresille.org:80/announce&tr=udp://tracker.openbittorrent.com:80&tr=udp://tracker.coppersurfer.tk:6969&tr=udp://tracker.leechers-paradise.org:6969&tr=udp://p4p.arenabg.ch:1337&tr=udp://tracker.internetwarriors.net:1337',
      seeders: 1007,
      leechers: 132,
      language: 'en',
      quality: '1080p',
      provider: 'YTS'
    }}

    initialize_with { new(link) }

    trait :show do
      link {{
        title: 'Game of Thrones 6x03',
        magnet: 'magnet:?xt=urn:btih:a9a56daf4339e7f098c35cf64d4ddfa8b9f95364&dn=Game.of.Thrones.S06E03.1080p.HDTV.x264-BATV%5Bettv%5D&tr=udp%3A%2F%2Ftracker.openbittorrent.com%3A80%2Fannounce&tr=udp%3A%2F%2Fglotorrents.pw%3A6969%2Fannounce&tr=udp%3A%2F%2Ftracker.openbittorrent.com%3A80%2Fannounce&tr=udp%3A%2F%2Ftracker.opentrackr.org%3A1337%2Fannounce&tr=udp%3A%2F%2Fzer0day.to%3A1337%2Fannounce&tr=udp%3A%2F%2Ftracker.coppersurfer.tk%3A6969%2Fannounce',
        seeders: 1232,
        leechers: 1274,
        language: 'en',
        quality: '1080p',
        provider: 'ETTV BATV'
      }}
    end
  end
end
