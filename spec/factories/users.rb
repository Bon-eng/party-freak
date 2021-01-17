FactoryBot.define do

  factory :user do
    nickname              { Faker::JapaneseMedia::Doraemon.character }
    email                 { Faker::Internet.free_email }
    password              { Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    gender_id             { 2 }
    profile               {Faker::JapaneseMedia::Doraemon.gadget}
    genre_id              { 2 }

  end
end