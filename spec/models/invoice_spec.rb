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
      #{packaged: 0, pending: 1, shipped: 2}
    end
    
    it "returns the IDs of incomplete invoices" do
      packaged_invoice_1 = create(:invoice_item, status: 0, created_at: Time.zone.parse('2022-01-03 12:00:00'))
      packaged_invoice_2 = create(:invoice_item, status: 0, created_at: Time.zone.parse('2022-01-07 12:00:00'))
      pending_invoice_1 = create(:invoice_item, status: 1, created_at: Time.zone.parse('2022-01-01 12:00:00'))
      pending_invoice_2 = create(:invoice_item, status: 1, created_at: Time.zone.parse('2022-01-10 12:00:00'))
      shipped_invoice_1 = create(:invoice_item, status: 2, created_at: Time.zone.parse('2022-01-05 12:00:00'))
      invoice_item_1 = pending_invoice_1.invoice
      invoice_item_2 = pending_invoice_1.invoice
      invoice_item_3 = packaged_invoice_1.invoice
      invoice_item_4 = packaged_invoice_1.invoice
      invoice_item_5 = shipped_invoice_1.invoice

      incomplete_ids = Invoice.incomplete_invoice_ids

      expect(incomplete_ids).to include(invoice_item_1, invoice_item_2, invoice_item_3, invoice_item_4)
      expect(incomplete_ids).not_to include(invoice_item_5)
    end

    it "orders the IDs by creation date" do
      invoice_1 = create(:invoice, status: "completed", created_at: Time.zone.parse("2022-03-01 12:00:00"))
      invoice_2 = create(:invoice, status: "in progress", created_at: Time.zone.parse("2022-01-01 12:00:00"))
      invoice_3 = create(:invoice, status: "completed", created_at: Time.zone.parse("2022-02-01 12:00:00"))
    
      result = Invoice.order_by_creation_date.to_a
    
      expect(result).to eq([invoice_2, invoice_3, invoice_1])
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