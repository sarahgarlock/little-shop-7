require 'rails_helper'
include FactoryBot::Syntax::Methods

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
            within "#merchants" do
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
    # 4. Merchant Dashboard Items Ready to Ship
    describe "Merchant Items with Invoices" do
        before :each do
            @merchant1 = Merchant.create!(name: "Pen Inc.")
            @item1 = Item.create!(name: "pen ink", description: "xxxxxxx", unit_price: 10, merchant_id: @merchant1.id)
            @item2 = Item.create!(name: "printer ink", description: "xxxxxxx", unit_price: 11, merchant_id: @merchant1.id)
            @item3 = Item.create!(name: "pens", description: "xxxxxxx", unit_price: 12, merchant_id: @merchant1.id)
            @customer1 = Customer.create!(first_name: "Andy", last_name: "S")
            @invoice1 = Invoice.create!(customer_id: @customer1.id, status: 1)
            @invoice2 = Invoice.create!(customer_id: @customer1.id, status: 1)
            @invoice3 = Invoice.create!(customer_id: @customer1.id, status: 1)
            @invoiceitem1 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 100, unit_price: 10, status: 1)
            @invoiceitem2 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice2.id, quantity: 100, unit_price: 10, status: 1)
            @invoiceitem3 = InvoiceItem.create!(item_id: @item3.id, invoice_id: @invoice3.id, quantity: 100, unit_price: 10, status: 1)
        end
        it "shows items ready to ship" do
            
            visit "/merchants/#{@merchant1.id}/dashboard"

            within "#merchant-items" do
                expect(page).to have_content("Items Ready To Ship")

                expect(page).to have_content(@invoiceitem1.item.name)
                expect(page).to have_link "#{@invoiceitem1.invoice_id}"

                expect(page).to have_content(@invoiceitem2.item.name)
                expect(page).to have_link "#{@invoiceitem2.invoice_id}"

                expect(page).to have_content(@invoiceitem3.item.name)
                expect(page).to have_link "#{@invoiceitem3.invoice_id}"

                click_link "#{@invoiceitem1.invoice_id}"
                expect(current_path).to eq("/merchants/#{@merchant1.id}/invoices/#{@invoiceitem1.invoice_id}")
            end
        end
    end
end
