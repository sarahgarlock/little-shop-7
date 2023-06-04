require "rails_helper" 

RSpec.describe "Admin Merchant Index", type: :feature do 
  before(:each) do 
    @merchant = create_list(:merchant, 6)
  end

  it "links to merchant show page" do 
    visit admin_merchants_path
    
    click_link "#{@merchant[0].name}"
    
    expect(current_path).to eq("/admin/merchants/#{@merchant[0].id}")
  end
  
  it "has buttons to disable or enable each merchant" do 
    visit admin_merchants_path

    within("#merchant-#{@merchant[0].id}") do 
      expect(page).to have_content("disabled")
    end
    
    within("#merchant-#{@merchant[1].id}") do 
      expect(page).to have_content("#{@merchant[0].status}")
    end
    
    expect(page).to have_button("Disable #{@merchant[0].name}")
    expect(page).to have_button("Disable #{@merchant[1].name}")
    expect(page).to have_button("Disable #{@merchant[2].name}")
    expect(page).to have_button("Disable #{@merchant[3].name}")
    expect(page).to have_button("Disable #{@merchant[4].name}")
    expect(page).to have_button("Disable #{@merchant[5].name}")
    expect(page).to have_button("Enable #{@merchant[5].name}")
    expect(page).to have_button("Enable #{@merchant[4].name}")
    expect(page).to have_button("Enable #{@merchant[3].name}")
    expect(page).to have_button("Enable #{@merchant[2].name}")
    expect(page).to have_button("Enable #{@merchant[1].name}")
    expect(page).to have_button("Enable #{@merchant[0].name}")
    click_button "Enable #{@merchant[0].name}"
    
    expect(current_path).to eq(admin_merchants_path)
    
    within("#merchant-#{@merchant[0].id}") do 
      expect(page).to have_content("enabled")
    end
  end

  it "displays merchants separated by status" do 
    @merchant[0].disabled!
    @merchant[1].disabled!
    @merchant[2].disabled!
    @merchant[3].enabled!
    @merchant[4].enabled!
    @merchant[5].enabled!

    visit admin_merchants_path

    within("#merchants-enabled") do 
      expect(page).to have_content("#{@merchant[3].name}")
      expect(page).to have_content("#{@merchant[4].name}")
      expect(page).to have_content("#{@merchant[5].name}")
    end


    within("#merchants-disabled") do 
      expect(page).to have_content("#{@merchant[0].name}")
      expect(page).to have_content("#{@merchant[1].name}")
      expect(page).to have_content("#{@merchant[2].name}")
    end
  end

  it "has a link to create a new merchant" do
    visit admin_merchants_path

    click_link "Create a New Merchant" 

    expect(current_path).to eq("/admin/merchants/new")
  end
end