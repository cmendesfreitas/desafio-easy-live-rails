FactoryBot.define do
  factory :store do
    name { Faker::Name.name }
    url { Faker::Internet.unique.url }
    active { [true, false].sample }
  end
end
