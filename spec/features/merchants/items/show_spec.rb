require 'rails_helper'

RSpec.describe 'Merchant Items', type: :feature do
  describe 'Merchant Items Show Page' do
    before :each do
      @merchant1 = Merchant.create!(name: "Pen Inc.")
      @merchant2 = Merchant.create!(name: "Ctrl+Alt+Elite")
      @item1 = Item.create!(name: "pen ink", description: "xxxxxxx", unit_price: 10, merchant_id: @merchant1.id)
      @item2 = Item.create!(name: "printer ink", description: "xxxxxxx", unit_price: 11, merchant_id: @merchant1.id)
      @item3 = Item.create!(name: "pens", description: "xxxxxxx", unit_price: 12, merchant_id: @merchant1.id)
      @item4 = Item.create!(name: "laptops", description: "xxxxxxx", unit_price: 12, merchant_id: @merchant2.id)
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

    # 7. Merchant Items Show Page
    it "links to item show page" do
      visit "/merchants/#{@merchant1.id}/items/#{@item1.id}"
      
      expect(page).to have_content(@item1.name)
      expect(page).to have_content(@item1.description)
      expect(page).to have_content(@item1.unit_price)
    end

    # 8. Merchant Item Update
    it "has edit item form" do
      visit "/merchants/#{@merchant1.id}/items/#{@item1.id}"

      expect(page).to have_link "Edit Item Information"
      click_link "Edit Item Information"
      expect(current_path).to eq("/merchants/#{@merchant1.id}/items/#{@item1.id}/edit")

      expect(page).to have_field("Name", with: "#{@item1.name}")
      expect(page).to have_field("Description", with: "#{@item1.description}")
      expect(page).to have_field("Unit price", with: "#{@item1.unit_price}")
      expect(page).to have_button "Submit"

      fill_in "Unit price", with: "Not a number"
      click_button "Submit"
      expect(current_path).to eq("/merchants/#{@merchant1.id}/items/#{@item1.id}/edit")
      expect(page).to have_content("Error: Valid data must be entered")

      fill_in "Name", with: "Cheeba Hut Sandwhiches"
      fill_in "Description", with: "Sub Sandwhich"
      fill_in "Unit price", with: 15
      click_button "Submit"

      expect(current_path).to eq("/merchants/#{@merchant1.id}/items/#{@item1.id}")
      expect(page).to have_content("Item Successfully Updated")
      expect(page).to have_content("Cheeba Hut Sandwhiches")
      expect(page).to have_content("Description: Sub Sandwhich")
      expect(page).to have_content("Current Price: 15")
    end
  end
end