FactoryBot.define do
  factory :user do
    nickname { Faker::Name.unique.name }
    email { Faker::Internet.unique.email }
    password { '1a1a1a' }
    password_confirmation { password }
    last_name { '田中' }
    first_name { '一郎' }
    last_name_kana { 'タナカ' }
    first_name_kana { 'ミニオン' }
    date_of_birth { Faker::Date.birthday(min_age: 18, max_age: 65) }
  end
end
