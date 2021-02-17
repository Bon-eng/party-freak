FactoryBot.define do

  factory :party do
    name         { '骨川スネ夫' }
    introduction { 'うちのパパ、えらいんだぞ。社長だぞ。' }
    season_id    { 2 }
    country_id   { 2 }
    genre_id     { 2 }
    official_url { 'https://www.suneo.com' }

    association :user
    

    after(:build) do |party|
      party.image.attach(io: File.open('public/images/test_image.jpg'), filename: 'test_image.jpg')
    end
  end
end
