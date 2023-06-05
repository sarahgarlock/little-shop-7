require "rails_helper" 

RSpec.describe "Admin Invoice Show Page", type: :feature do 
  before(:each) do 
    @customer = create(:customer)
    @invoice = @customer.create(:invoice)
  end

  it "displays all invoice attributes along with customer first and last name" do 
    visit admin_invoices_path(@invoice)

    expect(page).to have_content("#{@invoice.id}")
    expect(page).to have_content("#{@invoice.status}")
    expect(page).to have_content("#{@invoice.created_at.strftime("%A, %B %d, %Y")}")
    expect(page).to have_content("#{@customer.first_name}")
    expect(page).to have_content("#{@customer.last_name}")
  end
end