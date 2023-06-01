FactoryBot.define do
  factory :transaction do
    invoice
    credit_card_number { Faker::Bank.account_number(digits: 16) }
    credit_card_expiration
    result { [0,1].sample }
  end
end