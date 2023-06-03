require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe "relationships" do
    it { should belong_to :invoice }
    it { should belong_to :item }
  end

  describe ".incomplete_invoice_ids" do
    before(:each) do
      @packaged_invoice = create(:invoice_item, status: 0)
      @pending_invoice = create(:invoice_item, status: 1)
      @shipped_invoice = create(:invoice_item, status: 2)
      #{packaged: 0, pending: 1, shipped: 2}
    end

    it "returns the IDs of incomplete invoices" do
      incomplete_ids = InvoiceItem.incomplete_invoice_ids

      expect(incomplete_ids).to include(@packaged_invoice.invoice_id, @pending_invoice.invoice_id)
      expect(incomplete_ids).not_to include(@shipped_invoice.invoice_id)
    end
  end
end