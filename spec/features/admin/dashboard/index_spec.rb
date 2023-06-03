require 'rails_helper'

RSpec.describe 'Admin Dashboard', type: :feature do
  before :each do
    @customer_1 = Customer.create!(first_name: 'Jacky', last_name: 'Kennedy')
    @customer_2 = Customer.create!(first_name: 'Sir', last_name: 'Wiggles')
    @customer_3 = Customer.create!(first_name: 'Jason', last_name: 'Borne')
    @customer_4 = Customer.create!(first_name: 'Austin', last_name: 'Powers')
    @customer_5 = Customer.create!(first_name: 'Margaret', last_name: 'Thatcher')
    @customer_6 = Customer.create!(first_name: 'Benny', last_name: 'Jets')
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
    @transaction_20 = @invoice_6.transactions.create!(cc_num: 984787983476, 
                                        cc_exp: 23485720,
                                        result: 1)   
    @customer = create(:customer)
    @merchant = create(:merchant)
    @item = create(:item, merchant: @merchant)

    @invoice1 = create(:invoice, status: 0)
    @invoice2 = create(:invoice, status: 1)
    @invoice3 = create(:invoice, status: 2)
    #{packaged: 0, pending: 1, shipped: 2}

    @invoice_item1 = create(:invoice_item, status: 0, invoice: @invoice1, item: @item)
    @invoice_item2 = create(:invoice_item, status: 1, invoice: @invoice2, item: @item)
    @invoice_item3 = create(:invoice_item, status: 2, invoice: @invoice3, item: @item)    
    
    visit "/admin"                                        
  end

  describe "As an admin, when I visit the admin dashboard" do
    it "will display a header indicating that I am on the admin dashboard" do
      expect(page).to have_content("Admin Dashboard")
    end

    it "will display a link to the admin merchants index" do
      expect(page).to have_link("Merchants")

      click_link("Merchants")
      expect(current_path).to eq("/admin/merchants")
    end

    it "will display a link to the admin invoices index" do
      expect(page).to have_link("Invoices")

      click_link("Invoices")
      expect(current_path).to eq("/admin/invoices")
    end

    it "will display the top 5 customers with most successful transactions and their num of transactions" do 
      expect(page).to have_content("Top 5 Customers:")
      
      within("#top5") do 
        expect(page).to_not have_content("#{@customer_6.first_name}")
      end
      
      within("#top5-#{@customer_1.id}") do 
        expect(page).to have_content("#{@customer_1.first_name}")
        expect(page).to have_content("#{@customer_1.last_name}")
        expect(page).to have_content(@customer_1.count_success_transactions)
      end
      
      within("#top5-#{@customer_2.id}") do 
        expect(page).to have_content("#{@customer_2.first_name}")
        expect(page).to have_content("#{@customer_2.last_name}")
        expect(page).to have_content(@customer_2.count_success_transactions)
      end

      within("#top5-#{@customer_3.id}") do 
        expect(page).to have_content("#{@customer_3.first_name}")
        expect(page).to have_content("#{@customer_3.last_name}")
        expect(page).to have_content(@customer_3.count_success_transactions)
      end

      within("#top5-#{@customer_4.id}") do 
        expect(page).to have_content("#{@customer_4.first_name}")
        expect(page).to have_content("#{@customer_4.last_name}")
        expect(page).to have_content(@customer_4.count_success_transactions)
      end

      within("#top5-#{@customer_5.id}") do 
        expect(page).to have_content("#{@customer_5.first_name}")
        expect(page).to have_content("#{@customer_5.last_name}")
        expect(page).to have_content(@customer_5.count_success_transactions)
      end
      # save_and_open_page
    end
    
    it "will display a section for 'Incomplete Invoices'" do
      expect(page).to have_content("Incomplete Invoices")
    end

    it "displays a list of invoice IDs for incomplete invoices" do
      within("#incomplete-invoices") do
        expect(page).to have_content(@invoice1.id)
        expect(page).to have_content(@invoice2.id)
        expect(page).not_to have_content(@invoice3.id)
      end
    end
    
    it "will display each invoice id as a link to that invoice's admin show page" do
      expect(page).to have_link("Invoice ID ##{@invoice1.id}")
      click_link("Invoice ID ##{@invoice1.id}")

      expect(current_path).to eq(admin_invoice_path(@invoice1))
    end
  end
end