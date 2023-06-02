require 'rails_helper'

RSpec.describe 'Merchant Dashboard', type: :feature do
  before :each do
    @merchant1 = Merchant.create!(name: "Pen Inc.")
  end
  describe "Merchant/Dashboard#index" do
    it "displays name of merchant" do
      # 1. Merchant Dashboard

      # As a merchant,
      # When I visit my merchant dashboard (/merchants/:merchant_id/dashboard)
      # Then I see the name of my merchant

      visit "/merchants/#{@merchant1.id}/dashboard"
      expect(page).to have_content(@merchant1.name)
      expect(@merchant1.name).to eq("Pen Inc.")
    end

#   2.  Merchant Dashboard Links
    it "displays links to my merchant items index and merchant invoices index" do 
      visit "/merchants/#{@merchant1.id}/dashboard"

      expect(page).to have_link("My Items Index")
      expect(page).to have_link("My Invoices Index")
    end
  end
end