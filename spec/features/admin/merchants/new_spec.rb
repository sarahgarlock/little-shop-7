require "rails_helper" 

RSpec.describe "Admin New Merchant Page", type: :feature do 

  it "creates a new merchant" do
    # submit should redirect to admin merchants index

    visit "/admin/merchants/new" 

    fill_in "Name", with: "Awesome Sauce" 
    click_button "Save" 

    expect(current_path).to eq("/admin/merchants")
    expect(page).to have_content("Awesome Sauce")
    expect(Merchant.last.status).to eq("disabled")
  end
end