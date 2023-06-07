require 'rails_helper'

RSpec.describe 'Merchant Items', type: :feature do
  describe "merchant items index" do
    before :each do
      @merchant1 = Merchant.create!(name: "Pen Inc.")
      @merchant2 = Merchant.create!(name: "Ctrl+Alt+Elite")
      @item1 = Item.create!(name: "pen ink", description: "xxxxxxx", unit_price: 10, merchant_id: @merchant1.id, status: 0)
      @item2 = Item.create!(name: "printer ink", description: "xxxxxxx", unit_price: 11, merchant_id: @merchant1.id, status: 0)
      @item3 = Item.create!(name: "pens", description: "xxxxxxx", unit_price: 12, merchant_id: @merchant1.id, status: 1)
      @item4 = Item.create!(name: "laptops", description: "xxxxxxx", unit_price: 12, merchant_id: @merchant2.id, status: 0)
      @customer1 = Customer.create!(first_name: "Andy", last_name: "S")
      @customer2 = Customer.create!(first_name: "Billy", last_name: "Bob")
      @invoice1 = Invoice.create!(customer_id: @customer1.id, status: 1)
      @invoice2 = Invoice.create!(customer_id: @customer1.id, status: 1)
      @invoice3 = Invoice.create!(customer_id: @customer1.id, status: 1)
      @invoice4 = Invoice.create!(customer_id: @customer2.id, status: 1)
      @invoiceitem1 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 100, unit_price: 10, status: 1)
      @invoiceitem2 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice2.id, quantity: 100, unit_price: 10, status: 1)
      @invoiceitem3 = InvoiceItem.create!(item_id: @item3.id, invoice_id: @invoice3.id, quantity: 100, unit_price: 10, status: 1)
      @invoiceitem4 = InvoiceItem.create!(item_id: @item4.id, invoice_id: @invoice4.id, quantity: 10, unit_price: 1000, status: 1)
    end

    # 11. Merchant Item Create
    it "can add new items" do 
      visit "/merchants/#{@merchant1.id}/items"

      within "#disabled" do
        expect(page).to_not have_content("paper")
      end

      expect(page).to have_link "Create New Item"
      click_link "Create New Item"
      expect(current_path).to eq("/merchants/#{@merchant1.id}/items/new")

      expect(page).to have_field("Name")
      expect(page).to have_field("Description")
      expect(page).to have_field("Unit price")
      expect(page).to have_button "Submit"

      fill_in "name", with: "paper"
      fill_in "description", with: "abcde"
      fill_in "unit_price", with: "not_a_number"
      click_button "Submit"
      expect(current_path).to eq("/merchants/#{@merchant1.id}/items/new")
      expect(page).to have_content("Error: Valid data must be entered")
      fill_in "name", with: "paper"
      fill_in "description", with: "abcde"
      fill_in "unit_price", with: "15"
      click_button "Submit"

      
      expect(current_path).to eq("/merchants/#{@merchant1.id}/items")
      expect(page).to have_content("Item Successfully Created")
      expect(page).to have_content("paper Status: disabled")

      within "#disabled" do
        expect(page).to have_content("paper")
      end 
    end
  end
end
