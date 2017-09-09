module PopcorntimeSearch
  BASE_URL = 'https://tv-v2.api-fetch.website'.freeze
  SEASON_EPISODE_REGEXP = /s(?<season>\d{1,2})e(?<episode>\d{1,2})|(?<season>\d{1,2})x(?<episode>\d{1,2})/i
  TITLE_REGEXP = /(?<showname>['\w\s\.]+?)[\s\.-]*?(#{SEASON_EPISODE_REGEXP}|$)/i
end
