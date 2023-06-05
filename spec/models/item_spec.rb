require 'rails_helper'

RSpec.describe Item, type: :model do
  describe "relationships" do
    it { should belong_to :merchant }
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items)}
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:unit_price) }
    it { should validate_numericality_of(:unit_price) }
    it { should validate_presence_of(:merchant_id) }
  end

  describe "class methods" do
    before :each do
      @merchant1 = Merchant.create!(name: "Pen Inc.")
      @merchant2 = Merchant.create!(name: "Ctrl+Alt+Elite")
  
      @item1 = Item.create!(name: "Pen Ink", description: "xxxxxxx", unit_price: 10, merchant_id: @merchant1.id, status: 0)
      @item2 = Item.create!(name: "Printer Ink", description: "xxxxxxx", unit_price: 11, merchant_id: @merchant1.id, status: 0)
      @item3 = Item.create!(name: "Pens", description: "xxxxxxx", unit_price: 12, merchant_id: @merchant1.id, status: 1)
      @item4 = Item.create!(name: "Laptops", description: "xxxxxxx", unit_price: 12, merchant_id: @merchant2.id, status: 0)
      @item5 = Item.create!(name: "Notebooks", description: "Three Ring Binders", unit_price: 15, merchant_id: @merchant1.id, status: 0)
      @item6 = Item.create!(name: "Pencils", description: "#2", unit_price: 1, merchant_id: @merchant1.id, status: 0)
  
      @customer1 = Customer.create!(first_name: "Andy", last_name: "S")
      @customer2 = Customer.create!(first_name: "Billy", last_name: "Bob")
  
      @invoice1 = Invoice.create!(customer_id: @customer1.id, status: 1)
      @invoice2 = Invoice.create!(customer_id: @customer1.id, status: 1)
      @invoice3 = Invoice.create!(customer_id: @customer1.id, status: 1)
      @invoice4 = Invoice.create!(customer_id: @customer2.id, status: 1)
  
      @invoiceitem1 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 100, unit_price: 10, status: 1)
      @invoiceitem2 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice2.id, quantity: 100, unit_price: 11, status: 1)
      @invoiceitem3 = InvoiceItem.create!(item_id: @item3.id, invoice_id: @invoice3.id, quantity: 100, unit_price: 12, status: 1)
      @invoiceitem4 = InvoiceItem.create!(item_id: @item4.id, invoice_id: @invoice4.id, quantity: 10, unit_price: 12, status: 1)
      @invoiceitem5 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice1.id, quantity: 100, unit_price: 11, status: 1)
      @invoiceitem6 = InvoiceItem.create!(item_id: @item3.id, invoice_id: @invoice1.id, quantity: 100, unit_price: 12, status: 1)
      @invoiceitem7 = InvoiceItem.create!(item_id: @item5.id, invoice_id: @invoice1.id, quantity: 100, unit_price: 15, status: 1)
      @invoiceitem8 = InvoiceItem.create!(item_id: @item6.id, invoice_id: @invoice1.id, quantity: 100, unit_price: 1, status: 1)
  
      @transaction1 = Transaction.create!(invoice_id: @invoice1.id, cc_num: 1234567899876543, cc_exp: 23485720, result: 1)
    end

    it "revenue method" do
      expect(@merchant1.items.revenue).to eq([@item5, @item3, @item2, @item1, @item6])
    end
    it "item_rev_dollars method" do
      expect(@item1.item_rev_dollars).to eq(1000)
    end
  end
end