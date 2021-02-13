FactoryBot.define do

  factory :party do
    name         { Faker::JapaneseMedia::Doraemon.character }
    introduction { Faker::JapaneseMedia::Doraemon.character }
    season_id    { 2 }
    country_id   { 2 }
    genre_id     { 2 }
    official_url { Faker::JapaneseMedia::Doraemon.character }

    association :user
    

    after(:build) do |party|
      party.image.attach(io: File.open('public/images/test_image.jpg'), filename: 'test_image.jpg')
    end
  end
end
