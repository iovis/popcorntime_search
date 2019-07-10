FactoryBot.define do
  factory :movie_result, class: PopcorntimeSearch::MovieResult do
    result {{
      'title'   => 'The Godfather',
      'year'    => '1972',
      'imdb_id' => 'tt0068646'
    }}

    initialize_with { new(result) }
  end
end
