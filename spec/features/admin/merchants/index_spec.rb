require "rails_helper" 

RSpec.describe "Admin Merchant Index", type: :feature do 
  before(:each) do 
    @merchant = create_list(:merchant, 6)
  end
  it "displays a list of all merchants" do 
    visit admin_merchants_path

    expect(page).to have_content("Merchants")
    
    within("#merchants-list") do 
      expect(page).to have_content("#{@merchant[0].name}")
      expect(page).to have_content("#{@merchant[1].name}")
      expect(page).to have_content("#{@merchant[2].name}")
      expect(page).to have_content("#{@merchant[3].name}")
      expect(page).to have_content("#{@merchant[4].name}")
      expect(page).to have_content("#{@merchant[5].name}")
    end
  end
end