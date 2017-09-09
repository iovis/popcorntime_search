module PopcorntimeSearch
  SEASON_EPISODE_REGEXP = /s(?<season>\d{1,2})e(?<episode>\d{1,2})|(?<season>\d{1,2})x(?<episode>\d{1,2})/i
  SHOWNAME_REGEXP = /(?<showname>['\w\s\.]+?)[\s\.-]*?#{SEASON_EPISODE_REGEXP}/i
end
