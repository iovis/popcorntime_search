FactoryGirl.define do
  factory :link, class: PopcorntimeSearch::Link do
    link {{
      filename: 'The Godfather',
      size: '2.40 GB',
      magnet: 'magnet:?xt=urn:btih:5E915039C619366E490D08DB3FFED21F3A3AE84A&tr=udp://glotorrents.pw:6969/announce&tr=udp://tracker.opentrackr.org:1337/announce&tr=udp://torrent.gresille.org:80/announce&tr=udp://tracker.openbittorrent.com:80&tr=udp://tracker.coppersurfer.tk:6969&tr=udp://tracker.leechers-paradise.org:6969&tr=udp://p4p.arenabg.ch:1337&tr=udp://tracker.internetwarriors.net:1337',
      seeders: 1007,
      leechers: 132,
      language: 'en',
      quality: '1080p',
      provider: 'YTS'
    }}

    initialize_with { new(result) }
  end
end

