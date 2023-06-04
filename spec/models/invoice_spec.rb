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

  describe ".order_by_creation_date" do 
    before(:each) do 
      @invoice1 = create(:invoice, created_at: "2012-03-25 09:54:09 UTC")
      @invoice2 = create(:invoice, created_at: "2012-03-07 21:54:10 UTC")
      @invoice3 = create(:invoice, created_at: "2012-03-12 04:54:11 UTC")
      @invoice4 = create(:invoice, created_at: "2012-03-08 21:54:23 UTC")
      @invoice5 = create(:invoice, created_at: "2012-03-13 14:54:22 UTC")
      @invoice6 = create(:invoice, created_at: "2012-03-10 13:54:22 UTC")
    end

    it "returns invoices in order of date created" do 
      expected = [@invoice2, @invoice4, @invoice6, @invoice3, @invoice5, @invoice1]
      expect(Invoice.order_by_creation_date).to eq(expected)
    end
  end
end