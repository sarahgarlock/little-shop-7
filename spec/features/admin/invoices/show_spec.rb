require "rails_helper" 

RSpec.describe "Admin Invoice Show Page", type: :feature do 
  before(:each) do 
    @invoice = create(:invoice)
  end

  it "displays all invoice attributes along with customer first and last name" do 
    visit "/admin/invoices/#{@invoice.id}"
 
    expect(page).to have_content("ID: #{@invoice.id}")
    expect(page).to have_content("Status: #{@invoice.status}")
    expect(page).to have_content("Created at: #{@invoice.created_at.strftime("%A, %B %d, %Y")}")
    expect(page).to have_content("Customer: #{@invoice.customer.first_name}, #{@invoice.customer.last_name}")
  end
end