require 'rails_helper'

RSpec.describe 'Merchant Dashboard', type: :feature do
    before :each do
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
    describe "/merchant/dashboard" do
    # 1. Merchant Dashboard
        it "displays name of merchant" do
            visit "/merchants/#{@merchant1.id}/dashboard"
            expect(page).to have_content(@merchant1.name)
            expect(@merchant1.name).to eq("Pen Inc.")
        end
    #   2.  Merchant Dashboard Links
    it "displays links to my merchant items index and merchant invoices index" do 
        visit "/merchants/#{@merchant1.id}/dashboard"

        expect(page).to have_link("My Items")
        expect(page).to have_link("My Invoices")
    end
    # 3. Merchant Dashboard Statistics - Favorite Customers
        it "displays my top 5 customers and the number of successful transactions" do
            visit "/merchants/#{@merchant1.id}/dashboard"

            expect(page).to have_content("Top Customers:")
            expect(page).to have_content("#{@customer1.first_name} #{@customer1.last_name}")
            expect(page).to have_content("#{@customer2.first_name} #{@customer2.last_name}")
            expect(page).to have_content("#{@customer3.first_name} #{@customer3.last_name}")
            expect(page).to have_content("#{@customer4.first_name} #{@customer4.last_name}")
            expect(page).to have_content("#{@customer5.first_name} #{@customer5.last_name}")
            expect(page).to_not have_content("#{@customer6.first_name} #{@customer6.last_name}")
            
            expect(page).to have_content(@customer1.count_success_transactions)
            expect(page).to have_content(@customer2.count_success_transactions)
            expect(page).to have_content(@customer3.count_success_transactions)
            expect(page).to have_content(@customer4.count_success_transactions)
            expect(page).to have_content(@customer5.count_success_transactions)
            expect(page).to_not have_content(@customer6.count_success_transactions)
        end
    end
end
