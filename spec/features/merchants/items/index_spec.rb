require 'rails_helper'

RSpec.describe 'Merchant Items', type: :feature do
  describe "merchant items index" do
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

    # 6. Merchant Items Index Page
    it "lists items by merchant" do
      visit "/merchants/#{@merchant1.id}/items"
      expect(page).to have_content(@merchant1.name)

      within "#merchants_items" do
        expect(page).to have_content(@item1.name)
        expect(page).to have_content(@item2.name)
        expect(page).to have_content(@item3.name)

        expect(page).to_not have_content(@merchant2.name)
        expect(page).to_not have_content(@item4.name)
      end
    end

    # 7. Merchant Items Show Page
    it "links to item show page" do
      visit "/merchants/#{@merchant1.id}/items"

      within "#merchants_items" do
        expect(page).to have_link "#{@item1.name}"
        expect(page).to have_link "#{@item2.name}"
        expect(page).to have_link "#{@item3.name}"

        click_link "#{@item1.name}"
        expect(current_path).to eq("/merchants/#{@merchant1.id}/items/#{@item1.id}")
      end
    end
    
#   9.  Merchant Item Disable/Enable
    it "has a button to disable or enable an item" do 
      visit "/merchants/#{@merchant1.id}/items"

      within "#merchants_items-#{@item1.id}" do
        expect(page).to have_content("#{@item1.name} Status: enabled")
        expect(page).to have_button("Disable Item")
        click_button "Disable Item"
      end
      
      within "#merchants_items-#{@item1.id}" do
        expect(current_path).to eq("/merchants/#{@merchant1.id}/items")
        expect(page).to have_content("#{@item1.name} Status: disabled")
        expect(page).to have_button("Enable Item")
      end
    end
  end
end
