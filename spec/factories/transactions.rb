FactoryBot.define do
  factory :transaction do
    invoice
    cc_num { Faker::Bank.account_number(digits: 16) }
    cc_exp { Faker::Date.between(from: '2014-09-23', to: '2016-09-25') }
    result { [0,1].sample }
  end
end