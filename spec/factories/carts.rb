FactoryBot.define do
  factory :cart do
    association :user, factory: :user
    association :product, factory: :product
  end
end
