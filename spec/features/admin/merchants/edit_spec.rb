require "rails_helper" 

RSpec.describe "Admin Edit Merchant form page", type: :feature do 
  before(:each) do 
    @merchant = create_list(:merchant, 6)
  end

  it "has a form to update merchant information (valid data)" do 
    # form is pre-filled in with already existing merchant information
    # upon submit, client is redirected back to merchant's admin show page
    # with successful edit, flash message shows saying "Merchant successfully updated"

    visit "/admin/merchants/#{@merchant[0].id}/edit"

    fill_in "Name", with: "Forest Gump" 
    click_button "Submit"
    
    expect(page).to have_content("Merchant successfully updated")
    expect(current_path).to eq("/admin/merchants/#{@merchant[0].id}")
    expect(page).to have_content("Forest Gump")
  end

  it "has a form to update merchant information (invalid data)" do 
    # form is pre-filled in with already existing merchant information
    # upon submit, client is redirected back to merchant's admin show page
    # with successful edit, flash message shows saying "Merchant successfully updated"

    visit "/admin/merchants/#{@merchant[0].id}/edit"

    fill_in "Name", with: "" 
    click_button "Submit"

    expect(page).to have_content("Error: Name can't be blank.")
    expect(current_path).to eq("/admin/merchants/#{@merchant[0].id}/edit")
  end
end