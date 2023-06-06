require 'rails_helper'

RSpec.describe 'Merchant Invoices', type: :feature do
  describe "merchant invoice index page" do
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
      @invoiceitem2 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice2.id, quantity: 101, unit_price: 15, status: 1)
      @invoiceitem3 = InvoiceItem.create!(item_id: @item3.id, invoice_id: @invoice3.id, quantity: 105, unit_price: 20, status: 1)
      @invoiceitem4 = InvoiceItem.create!(item_id: @item4.id, invoice_id: @invoice4.id, quantity: 10, unit_price: 1000, status: 1)
    end

    # 14. Merchant Invoices Index  
    it "shows invoices on merchant invoices index page" do
      visit "/merchants/#{@merchant1.id}/invoices"

      expect(page).to have_link "#{@invoice1.id}"
      expect(page).to have_link "#{@invoice2.id}"
      expect(page).to have_link "#{@invoice3.id}"
      expect(page).to_not have_link "#{@invoice4.id}"
      
      click_link "#{@invoice1.id}"
      expect(current_path).to eq("/merchants/#{@merchant1.id}/invoices/#{@invoice1.id}")
    end
  end
end