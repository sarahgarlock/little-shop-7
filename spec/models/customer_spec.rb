require 'rails_helper'

RSpec.describe Customer, type: :model do
  before(:each) do 
    @customer_1 = Customer.create!(first_name: 'Jacky', last_name: 'Kennedy')
    @customer_2 = Customer.create!(first_name: 'Sir', last_name: 'Wiggles')
    @customer_3 = Customer.create!(first_name: 'Jason', last_name: 'Borne')
    @customer_4 = Customer.create!(first_name: 'Austin', last_name: 'Powers')
    @customer_5 = Customer.create!(first_name: 'Margaret', last_name: 'Thatcher')
    @customer_6 = Customer.create!(first_name: 'Jacky', last_name: 'Kennedy')
    @invoice_1 = @customer_1.invoices.create!(status: "completed")
    @invoice_2 = @customer_2.invoices.create!(status: "completed")
    @invoice_3 = @customer_3.invoices.create!(status: "completed")
    @invoice_4 = @customer_4.invoices.create!(status: "completed")
    @invoice_5 = @customer_5.invoices.create!(status: "completed")
    @invoice_6 = @customer_6.invoices.create!(status: "completed")
    @transaction_1 = @invoice_1.transactions.create!(cc_num: 467830927685, 
                                        cc_exp: 23485720,
                                        result: 0)
    @transaction_2 = @invoice_1.transactions.create!(cc_num: 467830207685, 
                                        cc_exp: 23485720,
                                        result: 0)
    @transaction_3 = @invoice_1.transactions.create!(cc_num: 467830201095, 
                                        cc_exp: 23485720,
                                        result: 0)
    @transaction_4 = @invoice_1.transactions.create!(cc_num: 467830257395, 
                                        cc_exp: 23485720,
                                        result: 0)
    @transaction_5 = @invoice_1.transactions.create!(cc_num: 469530201095, 
                                        cc_exp: 23485720,
                                        result: 0)
    @transaction_6 = @invoice_2.transactions.create!(cc_num: 469530201095, 
                                        cc_exp: 23485720,
                                        result: 0)
    @transaction_7 = @invoice_2.transactions.create!(cc_num: 4690980201095, 
                                        cc_exp: 23485720,
                                        result: 0)
    @transaction_8 = @invoice_2.transactions.create!(cc_num: 4695387901095, 
                                        cc_exp: 23485720,
                                        result: 0)
    @transaction_9 = @invoice_2.transactions.create!(cc_num: 469587980095, 
                                        cc_exp: 23485720,
                                        result: 0)
    @transaction_10 = @invoice_3.transactions.create!(cc_num: 265587980095, 
                                        cc_exp: 23485720,
                                        result: 0)
    @transaction_11 = @invoice_3.transactions.create!(cc_num: 976587980095, 
                                        cc_exp: 23485720,
                                        result: 0)
    @transaction_12 = @invoice_3.transactions.create!(cc_num: 375587980095, 
                                        cc_exp: 23485720,
                                        result: 0)
    @transaction_13 = @invoice_4.transactions.create!(cc_num: 375582980095, 
                                        cc_exp: 23485720,
                                        result: 0)
    @transaction_14 = @invoice_4.transactions.create!(cc_num: 375587980000, 
                                        cc_exp: 23485720,
                                        result: 0)
    @transaction_15 = @invoice_4.transactions.create!(cc_num: 375587982176, 
                                        cc_exp: 23485720,
                                        result: 0)
    @transaction_16 = @invoice_5.transactions.create!(cc_num: 876587982176, 
                                        cc_exp: 23485720,
                                        result: 0)
    @transaction_17 = @invoice_5.transactions.create!(cc_num: 187687982176, 
                                        cc_exp: 23485720,
                                        result: 0)
    @transaction_18 = @invoice_5.transactions.create!(cc_num: 984787982145, 
                                        cc_exp: 23485720,
                                        result: 0)
    @transaction_18 = @invoice_6.transactions.create!(cc_num: 984787982986, 
                                        cc_exp: 23485720,
                                        result: 0)
    @transaction_19 = @invoice_6.transactions.create!(cc_num: 984787982123, 
                                        cc_exp: 23485720,
                                        result: 1)
    @transaction_19 = @invoice_6.transactions.create!(cc_num: 984787983476, 
                                        cc_exp: 23485720,
                                        result: 1)
  end
  describe 'relationships' do
    it {should have_many :invoices }
    it {should have_many(:transactions).through(:invoices) }
  end

  describe 'class methods' do 
    it 'top_5' do 
      expected = [@customer_1, @customer_2, @customer_3, @customer_4, @customer_5]

      expect(Customer.top_5).to match_array(expected)
    end
  end

  describe 'instance methods' do 
    it 'count_success_transactions' do 
      expect(@customer_1.count_success_transactions).to eq(5)
      expect(@customer_3.count_success_transactions).to eq(3)
      expect(@customer_6.count_success_transactions).to eq(1)
    end
  end
end