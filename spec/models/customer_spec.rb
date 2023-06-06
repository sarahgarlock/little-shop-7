require 'rails_helper'
include FactoryBot::Syntax::Methods

RSpec.describe Customer, type: :model do
    before(:each) do 
        @merchant1 = Merchant.create!(name: "Pen Inc.")
        @merchant2 = Merchant.create!(name: "Ctrl+Alt+Elite")
        @item = create_list(:item, 6, merchant: @merchant1)
        @invoice = create_list(:invoice, 6, status: 1)
        @customer1 = @invoice[0].customer
        @customer2 = @invoice[1].customer
        @customer3 = @invoice[2].customer
        @customer4 = @invoice[3].customer
        @customer5 = @invoice[4].customer
        @customer6 = @invoice[5].customer
        @invoice_item1 = create(:invoice_item, item: @item[0], invoice: @invoice[0])
        @invoice_item2 = create(:invoice_item, item: @item[1], invoice: @invoice[1])
        @invoice_item3 = create(:invoice_item, item: @item[2], invoice: @invoice[2])
        @invoice_item4 = create(:invoice_item, item: @item[3], invoice: @invoice[3])
        @invoice_item5 = create(:invoice_item, item: @item[4], invoice: @invoice[4])
        @invoice_item6 = create(:invoice_item, item: @item[5], invoice: @invoice[5])
        @transaction_1 = @invoice[0].transactions.create!(cc_num: 467830927685, 
            cc_exp: 23485720,
            result: 0)
        @transaction_2 = @invoice[0].transactions.create!(cc_num: 467830207685, 
            cc_exp: 23485720,
            result: 0)
        @transaction_3 = @invoice[0].transactions.create!(cc_num: 467830201095, 
            cc_exp: 23485720,
            result: 0)
        @transaction_4 = @invoice[0].transactions.create!(cc_num: 467830257395, 
            cc_exp: 23485720,
            result: 0)
        @transaction_5 = @invoice[0].transactions.create!(cc_num: 469530201095, 
            cc_exp: 23485720,
            result: 0)
        @transaction_6 = @invoice[1].transactions.create!(cc_num: 469530201095, 
            cc_exp: 23485720,
            result: 0)
        @transaction_7 = @invoice[1].transactions.create!(cc_num: 4690980201095, 
            cc_exp: 23485720,
            result: 0)
        @transaction_8 = @invoice[1].transactions.create!(cc_num: 4695387901095, 
            cc_exp: 23485720,
            result: 0)
        @transaction_9 = @invoice[1].transactions.create!(cc_num: 469587980095, 
            cc_exp: 23485720,
            result: 0)
        @transaction_10 = @invoice[2].transactions.create!(cc_num: 265587980095, 
            cc_exp: 23485720,
            result: 0)
        @transaction_11 = @invoice[2].transactions.create!(cc_num: 976587980095, 
            cc_exp: 23485720,
            result: 0)
        @transaction_12 = @invoice[2].transactions.create!(cc_num: 375587980095, 
            cc_exp: 23485720,
            result: 0)
        @transaction_13 = @invoice[3].transactions.create!(cc_num: 375582980095, 
            cc_exp: 23485720,
            result: 0)
        @transaction_14 = @invoice[3].transactions.create!(cc_num: 375587980000, 
            cc_exp: 23485720,
            result: 0)
        @transaction_15 = @invoice[3].transactions.create!(cc_num: 375587982176, 
            cc_exp: 23485720,
            result: 0)
        @transaction_16 = @invoice[4].transactions.create!(cc_num: 876587982176, 
            cc_exp: 23485720,
            result: 0)
        @transaction_17 = @invoice[4].transactions.create!(cc_num: 187687982176, 
            cc_exp: 23485720,
            result: 0)
        @transaction_18 = @invoice[4].transactions.create!(cc_num: 984787982145, 
            cc_exp: 23485720,
            result: 0)
        @transaction_18 = @invoice[5].transactions.create!(cc_num: 984787982986, 
            cc_exp: 23485720,
            result: 0)
        @transaction_19 = @invoice[5].transactions.create!(cc_num: 984787982123, 
            cc_exp: 23485720,
            result: 1)
        @transaction_20 = @invoice[5].transactions.create!(cc_num: 984787983476, 
            cc_exp: 23485720,
            result: 1)
    end

    describe 'relationships' do
        it {should have_many :invoices }
        it {should have_many(:transactions).through(:invoices) }
    end

    describe 'validations' do
        it { should validate_presence_of(:first_name) }
        it { should validate_presence_of(:last_name) }
    end

    describe 'class methods' do 
        it 'top_5' do 
        expected = [@customer1, @customer2, @customer3, @customer4, @customer5]
        expect(Customer.top_5).to match_array(expected)
        end

        it "top_customers" do 
        expected = [@customer1, @customer2, @customer3, @customer4, @customer5]
        expect(Customer.top_customers(@merchant1.id)).to match_array(expected)
        end
    end

    describe 'instance methods' do 
        it 'count_success_transactions' do
        expect(@customer1.count_success_transactions).to eq(5)
        expect(@customer3.count_success_transactions).to eq(3)
        expect(@customer6.count_success_transactions).to eq(1)
        end
    end
end