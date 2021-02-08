FactoryBot.define do

  factory :party do
    name              { Faker::JapaneseMedia::Doraemon.character }
    introduction                 { Faker::Internet.free_email }
    password              { Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    gender_id             { 2 }
    profile               {Faker::JapaneseMedia::Doraemon.gadget}
    genre_id              { 2 }
    admin                 { false }
  end
end
