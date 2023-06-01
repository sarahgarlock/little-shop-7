FactoryBot.define do
  factory :item do
    name { Faker::Commerce.product_name }
    description { Faker::Lorem.sentence }
    unit_price { Faker::Number.within(range: 1..10000)}
    merchant
    # merchant association needed?
  end
end