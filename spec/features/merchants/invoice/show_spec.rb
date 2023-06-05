require 'rails_helper'

RSpec.describe 'Merchant Invoices', type: :feature do
  describe "merchant invoice show page" do
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
    # 15. Merchant Invoice Show Page
    it "displays information related to that invoice" do
      @invoice1_date = @invoice1.created_at.strftime("%A, %B %d, %Y")

      visit "/merchants/#{@merchant1.id}/invoices/#{@invoice1.id}"

      expect(page).to have_content("Invoice id: #{@invoice1.id}")
      expect(page).to have_content("Invoice status: #{@invoice1.status}")
      expect(page).to have_content("Invoice creation date: #{@invoice1_date}")
      expect(page).to have_content("Customer: #{@customer1.first_name} #{@customer1.last_name}")
    end
#   16. Merchant Invoice Show Page: Invoice Item Information
    it "shows all of my items and attributes on the invoice" do 
      visit "/merchants/#{@merchant1.id}/invoices/#{@invoice1.id}"

      expect(page).to have_content("#{@item1.name}")
      expect(page).to have_content("#{@invoiceitem1.quantity}")
      expect(page).to have_content("#{@invoiceitem1.unit_price}")
      expect(page).to have_content("#{@invoiceitem1.status}")

      expect(page).to_not have_content("#{@item2.name}")
      expect(page).to_not have_content("#{@item3.name}")
      expect(page).to_not have_content("#{@item4.name}")
    end
#   17. Merchant Invoice Show Page: Total Revenue
    it "shows the total revenue that will be generated from all of my items on the invoice" do 
      visit "/merchants/#{@merchant1.id}/invoices/#{@invoice1.id}"

      expect(page).to have_content("Total Revenue: 1000")
    end
  end
end
