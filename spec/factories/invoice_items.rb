FactoryBot.define do
  factory :invoice_item do
    item
    invoice
    quantity { Faker::Number.within(range: 1..10)}
    unit_price {Faker::Number.within(range:1..100)}
    status { [0,1,2].sample }
  end
end