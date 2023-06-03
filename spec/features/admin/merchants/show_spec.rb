require "rails_helper" 

RSpec.describe "Merchant show page", type: :feature do 
  before(:each) do 
    @merchant = create_list(:merchant, 6)
  end

  it "displays the merchant's name" do 
    visit "/admin/merchants/#{@merchant[0].id}"
    
    expect(page).to have_content(@merchant[0].name)
  end
  
  it "has a link to update the merchant's information" do 
    visit "/admin/merchants/#{@merchant[0].id}"

    click_link "Update Merchant" 

    expect(current_path).to eq("/admin/merchants/#{@merchant[0].id}/edit")
  end
end