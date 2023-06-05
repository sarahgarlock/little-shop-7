require "rails_helper" 

RSpec.describe "Admin Invoice Show Page", type: :feature do 
  before(:each) do 
    @customer = create(:customer)
    @invoice = @customer.create(:invoice)
  end

  it "displays all invoice attributes along with customer first and last name" do 
    visit admin_invoices_path(@invoice)
save_and_open_page 
    expect(page).to have_content("ID: #{@invoice.id}")
    expect(page).to have_content("Status: #{@invoice.status}")
    expect(page).to have_content("Created at: #{@invoice.created_at.strftime("%A, %B %d, %Y")}")
    expect(page).to have_content("Customer: #{@customer.first_name}, #{@customer.last_name}")
  end
end