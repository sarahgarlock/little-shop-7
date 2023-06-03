require 'rails_helper'

RSpec.describe 'Admin Dashboard', type: :feature do
  before :each do

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
      click_link("Invoice ##{@invoice1.id}")

      expect(current_path).to eq(admin_invoice_path(@invoice1))
    end
  end
end