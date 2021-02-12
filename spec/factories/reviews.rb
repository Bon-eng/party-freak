FactoryBot.define do

  factory :review do
    title       { Faker::JapaneseMedia::Doraemon.gadget }
    content     { Faker::JapaneseMedia::Doraemon.gadget }

    association :user
    association :party
    
    after(:build) do |review|
      review.image.attach(io: File.open('public/images/test_image.jpg'), filename: 'test_image.jpg')
    end
  end
end
