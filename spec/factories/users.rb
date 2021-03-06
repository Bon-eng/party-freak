FactoryBot.define do
  factory :user do
    nickname              { '野比のび太' }
    sequence(:email)      { |n| "tester#{n}@example.com" }
    password              { 'q11111' }
    password_confirmation { password }
    gender_id             { 2 }
    profile               { 'なんとかしてよドラえもん' }
    genre_id              { 2 }
    admin                 { false }
  end
end
