FactoryGirl.define do
  factory :search, class: PopcorntimeSearch::Search do
    search 'game of thrones s06e03'
    initialize_with { new(search) }

    trait :movie do
      search 'the godfather'
    end
  end
end