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

  describe "#total_revenue" do 
    it "calculates the total revenue for an invoice" do 
      @merchant1 = Merchant.create!(name: "Pen Inc.")
      @merchant2 = Merchant.create!(name: "Ctrl+Alt+Elite")
      @item1 = Item.create!(name: "pen ink", description: "xxxxxxx", unit_price: 10, merchant_id: @merchant1.id, status: 0)
      @item2 = Item.create!(name: "printer ink", description: "xxxxxxx", unit_price: 11, merchant_id: @merchant1.id, status: 0)
      @item3 = Item.create!(name: "pens", description: "xxxxxxx", unit_price: 12, merchant_id: @merchant1.id, status: 1)
      @item4 = Item.create!(name: "laptops", description: "xxxxxxx", unit_price: 12, merchant_id: @merchant2.id, status: 0)
      @customer1 = Customer.create!(first_name: "Andy", last_name: "S")
      @customer2 = Customer.create!(first_name: "Billy", last_name: "Bob")
      @invoice1 = Invoice.create!(customer_id: @customer1.id, status: 1)
      @invoice2 = Invoice.create!(customer_id: @customer1.id, status: 1)
      @invoice3 = Invoice.create!(customer_id: @customer1.id, status: 1)
      @invoice4 = Invoice.create!(customer_id: @customer2.id, status: 1)
      @invoiceitem1 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 100, unit_price: 10, status: 1)
      @invoiceitem2 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice2.id, quantity: 101, unit_price: 15, status: 1)
      @invoiceitem3 = InvoiceItem.create!(item_id: @item3.id, invoice_id: @invoice3.id, quantity: 105, unit_price: 20, status: 1)
      @invoiceitem4 = InvoiceItem.create!(item_id: @item4.id, invoice_id: @invoice4.id, quantity: 10, unit_price: 1000, status: 1)

      expect(@invoice1.total_revenue(@invoice1)).to eq(1000)
    end
  end
end