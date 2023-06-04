require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe "relationships" do
    it { should belong_to :customer }
    it { should have_many :transactions }
    it { should have_many :invoice_items }
    it { should have_many(:items).through(:invoice_items) }
  end

  describe ".incomplete_invoice_ids" do
    before(:each) do
      @packaged_invoice = create(:invoice_item, status: 0)
      @pending_invoice = create(:invoice_item, status: 1)
      @shipped_invoice = create(:invoice_item, status: 2)
      @pending_test = @pending_invoice.invoice
      @pending_test2 = @packaged_invoice.invoice
      @pending_test3 = @shipped_invoice.invoice
      #{packaged: 0, pending: 1, shipped: 2}
    end

    it "returns the IDs of incomplete invoices" do
      incomplete_ids = Invoice.incomplete_invoice_ids

      expect(incomplete_ids).to include(@pending_test, @pending_test2)
      expect(incomplete_ids).not_to include(@shipped_invoice.invoice_id)
    end
  end
end