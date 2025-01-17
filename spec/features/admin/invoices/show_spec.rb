require "rails_helper" 

RSpec.describe "Admin Invoice Show Page", type: :feature do 
  before(:each) do 
    @customer = Customer.create!(first_name: "Jenny", last_name: "Lawson")
    @merchant = Merchant.create!(name: "Pens R Us")
    @invoice = Invoice.create!(status: 0, created_at: "Mon, 05 Jun 2023 19:24:50.249300000 UTC +00:00", customer_id: @customer.id)
    @item1 = create(:item, merchant_id: @merchant.id)
    @item2 = create(:item, merchant_id: @merchant.id)
    @item3 = create(:item, merchant_id: @merchant.id)
    @item4 = create(:item, merchant_id: @merchant.id)
    @invoice_item1 = InvoiceItem.create!(unit_price: 3, quantity: 5, item_id: @item1.id, invoice_id: @invoice.id, status: 0)
    @invoice_item2 = InvoiceItem.create!(unit_price: 8, quantity: 10, item_id: @item2.id, invoice_id: @invoice.id, status: 1)
    @invoice_item3= InvoiceItem.create!(unit_price: 10, quantity: 12, item_id: @item3.id, invoice_id: @invoice.id, status: 2)
    @invoice_item4 = InvoiceItem.create!(unit_price: 12, quantity: 4, item_id: @item4.id, invoice_id: @invoice.id, status: 0)
  end

  it "displays all invoice attributes along with customer first and last name" do 
    visit "/admin/invoices/#{@invoice.id}"
    
    expect(page).to have_content("ID: #{@invoice.id}")
    expect(page).to have_content("Status: #{@invoice.status}")
    expect(page).to have_content("Created at: #{@invoice.created_at.strftime("%A, %B %d, %Y")}")
    expect(page).to have_content("Customer: #{@invoice.customer.first_name}, #{@invoice.customer.last_name}")
    expect(page).to have_content("Total Revenue: #{@invoice.total_revenue}")
  end
  
  it "displays all items' information for each invoice" do 
    visit "/admin/invoices/#{@invoice.id}"
    
    within("#item-#{@item1.id}") do 
      expect(page).to have_content("Item: #{@item1.name}")
      expect(page).to have_content("Quantity: #{@invoice.quantity_of_item(@item1)}")
      expect(page).to have_content("Item sold for: #{@invoice.price_sold(@item1)}")
      expect(page).to have_content("Order Status: #{@invoice.invoice_item_status(@item1)}")
    end

    within("#item-#{@item2.id}") do 
      expect(page).to have_content("Item: #{@item2.name}")
      expect(page).to have_content("Quantity: #{@invoice.quantity_of_item(@item2)}")
      expect(page).to have_content("Item sold for: #{@invoice.price_sold(@item2)}")
      expect(page).to have_content("Order Status: #{@invoice.invoice_item_status(@item2)}")
    end
  end

  it "displays a form to update the invoice status" do 
    visit "/admin/invoices/#{@invoice.id}"
    expect(page).to have_content("Invoice Status:")
    expect(page).to have_field("status", with: "#{@invoice.status}")
    
    page.select "in progress", from: "status" 
    click_button "Update Invoice Status"
    
    expect(current_path).to eq("/admin/invoices/#{@invoice.id}")
    expect(page).to have_field("status", with: "in progress")

    page.select "cancelled", from: "status" 
    click_button "Update Invoice Status"
    
    expect(current_path).to eq("/admin/invoices/#{@invoice.id}")
    expect(page).to have_field("status", with: "cancelled")
  end
end