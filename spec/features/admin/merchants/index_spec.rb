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
      expect(page).to havecontent("#{@merchant[5].name}")
    end
  end

  it "links to merchant show page" do 
    visit admin_merchants_path
    
    click_link "#{@merchant[0].name}"
    
    expect(current_path).to eq("/admin/merchants/#{@merchant[0].id}")
  end
  
  it "has buttons to disable or enable each merchant" do 
    visit admin_merchants_path

    within("#merchant-#{@merchant[0].id}") do 
      expect(page).to have_content("enabled")
    end
    
    within("#merchant-#{@merchant[1].id}") do 
      expect(page).to have_content("#{@merchant[0].status}")
    end
    
    expect(page).to have_content("Disable #{@merchant[0].name}")
    expect(page).to have_content("Disable #{@merchant[1].name}")
    expect(page).to have_content("Disable #{@merchant[2].name}")
    expect(page).to have_content("Disable #{@merchant[3].name}")
    expect(page).to have_content("Disable #{@merchant[4].name}")
    expect(page).to have_content("Disable #{@merchant[5].name}")
    expect(page).to have_content("Enable #{@merchant[5].name}")
    expect(page).to have_content("Enable #{@merchant[4].name}")
    expect(page).to have_content("Enable #{@merchant[3].name}")
    expect(page).to have_content("Enable #{@merchant[2].name}")
    expect(page).to have_content("Enable #{@merchant[1].name}")
    expect(page).to have_content("Enable #{@merchant[0].name}")
    
    click_button "Disable #{@merchant[0].name}"
    
    expect(current_path).to eq(admin_merchants_path)
    
    within("#merchant-#{@merchant[0].id}") do 
      expect(page).to have_content("disabled")
    end
  end
end