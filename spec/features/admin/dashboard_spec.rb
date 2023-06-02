require 'rails_helper'

RSpec.describe 'Admin Dashboard', type: :feature do
  before :each do
    visit "/admin"
  end

  describe "As an admin, when I visit the admin dashboard" do
    it "will display a header indicating that I am on the admin dashboard" do
      expect(page).to have_content("Admin Dashboard")
    end

    it "will display a link to the admin merchants index" do
      expect(page).to have_link("Merchants")

      click_link("Merchants")
      expect(current_path).to eq("/admin/merchants")
    end

    it "will display a link to the admin invoices index" do
      expect(page).to have_link("Invoices")

      save_and_open_page
      click_link("Invoices")
      expect(current_path).to eq("/admin/invoices")
    end
  end
end