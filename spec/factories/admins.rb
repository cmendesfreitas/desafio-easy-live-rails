FactoryBot.define do
  factory :admin do
    name { Faker::Name.name }
    password { Faker::Internet.password(min_length: 6, max_length: 20) }
    password_confirmation { password }
    email { Faker::Internet.unique.email }
  end
end
