FactoryBot.define do
  factory :product do
    product_id { Faker::Internet.unique.uuid }
    name { Faker::Name.name }
    price { Faker::Number.positive.round(2) }
    original_price { Faker::Number.decimal(l_digits: 2) }
    number_of_installments { Faker::Number.non_zero_digit }
    installments_full_price { Faker::Number.decimal(l_digits: 2) }
    image_url { Faker::Internet.unique.url }
    available_quantity { Faker::Number.positive }
    association :store, factory: :store
    active { [true, false].sample }
  end
end
