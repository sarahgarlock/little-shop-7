require 'rails_helper'

RSpec.describe 'Admin Dashboard', type: :feature do
  describe "As an admin, when I visit the admin dashboard" do
    it "will display a header indicating that I am on the admin dashboard" do
      
      visit "/admin"
      expect(page).to have_content("Admin Dashboard")
    end
  end
end