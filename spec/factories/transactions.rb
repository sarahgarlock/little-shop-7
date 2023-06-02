FactoryBot.define do
  factory :transaction do
    invoice
    credit_card_number { Faker::Bank.account_number(digits: 16) }
    credit_card_expiration { Faker::Date.between(from: '2014-09-23', to: '2016-09-25') }
    result { [0,1].sample }
  end
end