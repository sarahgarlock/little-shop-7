require "rails_helper" 

RSpec.describe "Merchant show page", type: :feature do 
  before(:each) do 
    @merchant = create_list(:merchant, 6)
  end

  it "displays the merchant's name" do 
    visit admin_merchants_path(@merchant[0])

    expect(page).to have_content(@merchant[0].name)
  end
end