require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe 'relationships' do
    it { should belong_to :invoice }
    it { should have_many(:invoice_items).through(:invoice) }
  end

  describe "validations" do
    it { should validate_presence_of(:cc_num) }
    it { should validate_numericality_of(:cc_num) }
    it { should validate_presence_of(:result) }
  end
end