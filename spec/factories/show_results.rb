FactoryBot.define do
  factory :show_result, class: PopcorntimeSearch::ShowResult do
    result {{
      'title'   => 'Game of Thrones',
      'year'    => '2011',
      'imdb_id' => 'tt0944947'
    }}

    season  { 6 }
    episode { 3 }

    initialize_with { new(result, season, episode) }

    trait :nonexistent do
      episode { 20 }
    end

    trait :full_season do
      episode { nil }
    end
  end
end
