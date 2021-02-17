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

  factory :admin_user do
    nickname              { 'ドラえもん' }
    email                 { 'dora@emon' }
    password              { 'a11111' }
    password_confirmation { password }
    gender_id             { 4 }
    profile               { 'いつまでも子供じゃないんだよしっかりしろよ' }
    genre_id              { 4 }
    admin                 { true }
  end

end