require "rails_helper" 

RSpec.describe "Admin Invoices Index page", type: :feature do 
  before(:each) do 
    @customer = create(:customer)
    @invoice = @customer.create_list(:invoice, 5)
  end
  it "displays the ids of all invoices in system" do
    visit admin_invoices_path
    expect(page).to have_content("All Invoices")
    expect(page).to have_content("#{@invoice[0].id}")
    expect(page).to have_content("#{@invoice[1].id}")
    expect(page).to have_content("#{@invoice[2].id}")
    expect(page).to have_content("#{@invoice[3].id}")
    expect(page).to have_content("#{@invoice[4].id}")
  end
  
  it "links to the invoice show page for each invoice id" do 
    visit admin_invoices_path

    click_link "#{@invoice[0].id}"

    expect(current_path).to eq("/admin/invoices/#{@invoice[0].id}")
  end
end