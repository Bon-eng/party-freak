FactoryBot.define do

  factory :review do
    title       { Faker::JapaneseMedia::Doraemon.gadget }
    content     { Faker::JapaneseMedia::Doraemon.gadget }
    association :user
    association :party
  end
end
