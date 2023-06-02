require 'rails_helper'
include FactoryBot::Syntax::Methods

RSpec.describe 'Merchant Dashboard', type: :feature do
  before :each do
    @merchant1 = Merchant.create!(name: "Pen Inc.")
    @merchant2 = Merchant.create!(name: "Ctrl+Alt+Elite")
    @item = create_list(:item, 6, merchant: @merchant1)
    @invoice1 = create(:invoice)
    @invoice2 = create(:invoice)
    @invoice3 = create(:invoice)
    @invoice4 = create(:invoice)
    @invoice5 = create(:invoice)
    @invoice6 = create(:invoice)
    @customer1 = @invoice1.customer
    @customer2 = @invoice2.customer
    @customer3 = @invoice3.customer
    @customer4 = @invoice4.customer
    @customer5 = @invoice5.customer
    @customer6 = @invoice6.customer
    @invoice_item1 = create(:invoice_item, item: @item[0], invoice: @invoice1)
    @invoice_item2 = create(:invoice_item, item: @item[1], invoice: @invoice2)
    @invoice_item3 = create(:invoice_item, item: @item[2], invoice: @invoice3)
    @invoice_item4 = create(:invoice_item, item: @item[3], invoice: @invoice4)
    @invoice_item5 = create(:invoice_item, item: @item[4], invoice: @invoice5)
    @invoice_item6 = create(:invoice_item, item: @item[5], invoice: @invoice6)
    @transaction1 = @invoice1.transactions.create!(cc_num: 467830927685, 
                                        cc_exp: 23485720,
                                        result: 0)
    @transaction2 = @invoice1.transactions.create!(cc_num: 467830207685, 
                                        cc_exp: 23485720,
                                        result: 0)
    @transaction3 = @invoice1.transactions.create!(cc_num: 467830201095, 
                                        cc_exp: 23485720,
                                        result: 0)
    @transaction4 = @invoice1.transactions.create!(cc_num: 467830257395, 
                                        cc_exp: 23485720,
                                        result: 0)
    @transaction5 = @invoice1.transactions.create!(cc_num: 469530201095, 
                                        cc_exp: 23485720,
                                        result: 0)
    @transaction6 = @invoice2.transactions.create!(cc_num: 469530201095, 
                                        cc_exp: 23485720,
                                        result: 0)
    @transaction7 = @invoice2.transactions.create!(cc_num: 4690980201095, 
                                        cc_exp: 23485720,
                                        result: 0)
    @transaction8 = @invoice2.transactions.create!(cc_num: 4695387901095, 
                                        cc_exp: 23485720,
                                        result: 0)
    @transaction9 = @invoice2.transactions.create!(cc_num: 469587980095, 
                                        cc_exp: 23485720,
                                        result: 0)
    @transaction10 = @invoice3.transactions.create!(cc_num: 265587980095, 
                                        cc_exp: 23485720,
                                        result: 0)
    @transaction11 = @invoice3.transactions.create!(cc_num: 976587980095, 
                                        cc_exp: 23485720,
                                        result: 0)
    @transaction12 = @invoice3.transactions.create!(cc_num: 375587980095, 
                                        cc_exp: 23485720,
                                        result: 0)
    @transaction13 = @invoice4.transactions.create!(cc_num: 375582980095, 
                                        cc_exp: 23485720,
                                        result: 0)
    @transaction14 = @invoice4.transactions.create!(cc_num: 375587980000, 
                                        cc_exp: 23485720,
                                        result: 0)
    @transaction15 = @invoice4.transactions.create!(cc_num: 375587982176, 
                                        cc_exp: 23485720,
                                        result: 0)
    @transaction16 = @invoice5.transactions.create!(cc_num: 876587982176, 
                                        cc_exp: 23485720,
                                        result: 0)
    @transaction17 = @invoice5.transactions.create!(cc_num: 187687982176, 
                                        cc_exp: 23485720,
                                        result: 0)
    @transaction18 = @invoice5.transactions.create!(cc_num: 984787982145, 
                                        cc_exp: 23485720,
                                        result: 0)
    @transaction18 = @invoice6.transactions.create!(cc_num: 984787982986, 
                                        cc_exp: 23485720,
                                        result: 0)
    @transaction19 = @invoice6.transactions.create!(cc_num: 984787982123, 
                                        cc_exp: 23485720,
                                        result: 1)
    @transaction20 = @invoice6.transactions.create!(cc_num: 984787983476, 
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
