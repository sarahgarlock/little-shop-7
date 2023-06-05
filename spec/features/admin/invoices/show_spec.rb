require "rails_helper" 

RSpec.describe "Admin Invoice Show Page", type: :feature do 
  before(:each) do 
    @invoice = create(:invoice)
    @item1 = @invoice.create(:item)
    @item2 = @invoice.create(:item)
    @item3 = @invoice.create(:item)
    @item4 = @invoice.create(:item)
  end

  it "displays all invoice attributes along with customer first and last name" do 
    visit "/admin/invoices/#{@invoice.id}"
    
    expect(page).to have_content("ID: #{@invoice.id}")
    expect(page).to have_content("Status: #{@invoice.status}")
    expect(page).to have_content("Created at: #{@invoice.created_at.strftime("%A, %B %d, %Y")}")
    expect(page).to have_content("Customer: #{@invoice.customer.first_name}, #{@invoice.customer.last_name}")
  end
  
  it "displays all items' information for each invoice" do 
    visit "/admin/invoices/#{@invoice.id}"
    save_and_open_page
    expect(page).to have_content("Item: #{@item1.name}")
    expect(page).to have_content("Quantity: #{@item1.invoice_item.quantity}")
    expect(page).to have_content("Item sold for: #{@item1.invoice_item.unit_price}")
    expect(page).to have_content("Order Status: #{@item1.invoice_item.status}")
  end
end