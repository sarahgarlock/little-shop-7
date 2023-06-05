require 'rails_helper'

RSpec.describe 'Merchant Dashboard', type: :feature do
    before :each do
        @merchant1 = Merchant.create!(name: "Pen Inc.")
        @merchant2 = Merchant.create!(name: "Ctrl+Alt+Elite")
        @item1 = Item.create!(name: "pen ink", description: "xxxxxxx", unit_price: 10, merchant_id: @merchant1.id)
        @item2 = Item.create!(name: "printer ink", description: "xxxxxxx", unit_price: 11, merchant_id: @merchant1.id)
        @item3 = Item.create!(name: "pens", description: "xxxxxxx", unit_price: 12, merchant_id: @merchant1.id)
        @item4 = Item.create!(name: "paper", description: "xxxxxxx", unit_price: 20, merchant_id: @merchant1.id)
        @item5 = Item.create!(name: "paperclips", description: "xxxxxxx", unit_price: 20, merchant_id: @merchant1.id)
        @item6 = Item.create!(name: "white-out", description: "xxxxxxx", unit_price: 5, merchant_id: @merchant1.id)
        @customer1 = create(:customer)
        @customer2 = create(:customer)
        @customer3 = create(:customer)
        @customer4 = create(:customer)
        @customer5 = create(:customer)
        @customer6 = create(:customer)
        @invoice1 = Invoice.create!(customer_id: @customer1.id, status: 1)
        @invoice2 = Invoice.create!(customer_id: @customer1.id, status: 1)
        @invoice3 = Invoice.create!(customer_id: @customer1.id, status: 1)
        @invoice4 = Invoice.create!(customer_id: @customer2.id, status: 1)
        @invoice5 = Invoice.create!(customer_id: @customer3.id, status: 1)
        @invoice6 = Invoice.create!(customer_id: @customer4.id, status: 1)
        @invoice7 = Invoice.create!(customer_id: @customer5.id, status: 1)
        @invoice8 = Invoice.create!(customer_id: @customer6.id, status: 1)
        @invoice_item1 = create(:invoice_item, item: @item1, invoice: @invoice1)
        @invoice_item2 = create(:invoice_item, item: @item2, invoice: @invoice4)
        @invoice_item3 = create(:invoice_item, item: @item3, invoice: @invoice5)
        @invoice_item4 = create(:invoice_item, item: @item4, invoice: @invoice6)
        @invoice_item5 = create(:invoice_item, item: @item5, invoice: @invoice7)
        @invoice_item6 = create(:invoice_item, item: @item6, invoice: @invoice8)
        @transaction_1 = @invoice1.transactions.create!(cc_num: 467830927685, 
            cc_exp: 23485720,
            result: 0)
        @transaction_2 = @invoice1.transactions.create!(cc_num: 467830207685, 
            cc_exp: 23485720,
            result: 0)
        @transaction_3 = @invoice1.transactions.create!(cc_num: 467830201095, 
            cc_exp: 23485720,
            result: 0)
        @transaction_4 = @invoice1.transactions.create!(cc_num: 467830257395, 
            cc_exp: 23485720,
            result: 0)
        @transaction_5 = @invoice1.transactions.create!(cc_num: 469530201095, 
            cc_exp: 23485720,
            result: 0)
        @transaction_6 = @invoice4.transactions.create!(cc_num: 469530201095, 
            cc_exp: 23485720,
            result: 0)
        @transaction_7 = @invoice4.transactions.create!(cc_num: 4690980201095, 
            cc_exp: 23485720,
            result: 0)
        @transaction_8 = @invoice4.transactions.create!(cc_num: 4695387901095, 
            cc_exp: 23485720,
            result: 0)
        @transaction_9 = @invoice4.transactions.create!(cc_num: 469587980095, 
            cc_exp: 23485720,
            result: 0)
        @transaction_10 = @invoice5.transactions.create!(cc_num: 265587980095, 
            cc_exp: 23485720,
            result: 0)
        @transaction_11 = @invoice5.transactions.create!(cc_num: 976587980095, 
            cc_exp: 23485720,
            result: 0)
        @transaction_12 = @invoice5.transactions.create!(cc_num: 375587980095, 
            cc_exp: 23485720,
            result: 0)
        @transaction_13 = @invoice6.transactions.create!(cc_num: 375582980095, 
            cc_exp: 23485720,
            result: 0)
        @transaction_14 = @invoice6.transactions.create!(cc_num: 375587980000, 
            cc_exp: 23485720,
            result: 0)
        @transaction_15 = @invoice6.transactions.create!(cc_num: 375587982176, 
            cc_exp: 23485720,
            result: 0)
        @transaction_16 = @invoice7.transactions.create!(cc_num: 876587982176, 
            cc_exp: 23485720,
            result: 0)
        @transaction_17 = @invoice7.transactions.create!(cc_num: 187687982176, 
            cc_exp: 23485720,
            result: 0)
        @transaction_18 = @invoice7.transactions.create!(cc_num: 984787982145, 
            cc_exp: 23485720,
            result: 0)
        @transaction_18 = @invoice8.transactions.create!(cc_num: 984787982986, 
            cc_exp: 23485720,
            result: 0)
        @transaction_19 = @invoice8.transactions.create!(cc_num: 984787982123, 
            cc_exp: 23485720,
            result: 1)
        @transaction_20 = @invoice8.transactions.create!(cc_num: 984787983476, 
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
#   5. Merchant Dashboard Invoices sorted by least recent
        it "displays the items ready to ship with invoice creation date, ordered oldest to newest" do 
            @invoice1_date = @invoice1.created_at.strftime("%A, %B %d, %Y")
            @invoice4_date = @invoice4.created_at.strftime("%A, %B %d, %Y")
            @invoice5_date = @invoice4.created_at.strftime("%A, %B %d, %Y")

            visit "/merchants/#{@merchant1.id}/dashboard"

            within("#merchant-items") do 
                expect(page).to have_content("#{@item1.name} - Created: #{@invoice1_date}")
                expect(page).to have_content("#{@item2.name} - Created: #{@invoice4_date}")
                expect(page).to have_content("#{@item3.name} - Created: #{@invoice5_date}")
                expect("#{@item1.name}").to appear_before("#{@item2.name}")
                expect("#{@item2.name}").to appear_before("#{@item3.name}")
            end
        end
    end
end
