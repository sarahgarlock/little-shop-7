require 'rails_helper'

RSpec.describe Merchant, type: :model do
  before :each do
    @merchant1 = Merchant.create!(name: "Pen Inc.")
    @item1 = Item.create!(name: "pen ink", description: "xxxxxxx", unit_price: 10, merchant_id: @merchant1.id)
    @item2 = Item.create!(name: "printer ink", description: "xxxxxxx", unit_price: 11, merchant_id: @merchant1.id)
    @item3 = Item.create!(name: "pens", description: "xxxxxxx", unit_price: 12, merchant_id: @merchant1.id)
    @customer1 = Customer.create!(first_name: "Andy", last_name: "S")
    @invoice1 = Invoice.create!(customer_id: @customer1.id, status: 1, created_at: "2023-06-03 03:49:12.81835")
    @invoice2 = Invoice.create!(customer_id: @customer1.id, status: 1, created_at: "2023-06-02 03:49:12.81835")
    @invoice3 = Invoice.create!(customer_id: @customer1.id, status: 1, created_at: "2023-06-06 03:49:12.81835")
    @transaction1 = @invoice1.transactions.create!(result: 1)
    @transaction2 = @invoice2.transactions.create!(result: 1)
    @transaction3 = @invoice3.transactions.create!(result: 1)
    @invoiceitem1 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 100, unit_price: 10, status: 1)
    @invoiceitem2 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice2.id, quantity: 100, unit_price: 10, status: 1)
    @invoiceitem3 = InvoiceItem.create!(item_id: @item3.id, invoice_id: @invoice3.id, quantity: 100, unit_price: 10, status: 1)
    
  end
  describe 'relationships' do
    it { should have_many :items }
    it { should have_many(:invoice_items).through(:items)}
  end

  describe 'validations' do 
    it { should validate_presence_of(:name) }
  end
  
  describe 'instance methods' do
    it 'items_ready_to_ship' do
      expect(@merchant1.items_ready_to_ship).to eq([@item1, @item2, @item3])
    end

    it 'update_status' do 
      expect(@merchant1.status).to eq("disabled")

      @merchant1.update_status("0")

      expect(@merchant1.status).to eq("enabled")

      @merchant1.update_status("1")

      expect(@merchant1.status).to eq("disabled")

      expect(@merchant1.update_status("foo")).to eq("invalid code")
    end

    it 'best_day' do 
      invoiceitem4 = InvoiceItem.create!(item_id: @item3.id, invoice_id: @invoice3.id, quantity: 100, unit_price: 10, status: 1)
      invoiceitem5 = InvoiceItem.create!(item_id: @item3.id, invoice_id: @invoice2.id, quantity: 100, unit_price: 10, status: 1)
      invoiceitem6 = InvoiceItem.create!(item_id: @item3.id, invoice_id: @invoice1.id, quantity: 100, unit_price: 10, status: 1)
      invoiceitem7 = InvoiceItem.create!(item_id: @item3.id, invoice_id: @invoice1.id, quantity: 100, unit_price: 10, status: 1)
      invoiceitem8 = InvoiceItem.create!(item_id: @item3.id, invoice_id: @invoice3.id, quantity: 100, unit_price: 10, status: 1)
      invoiceitem9 = InvoiceItem.create!(item_id: @item3.id, invoice_id: @invoice3.id, quantity: 100, unit_price: 10, status: 1)
      @invoice1.reload
      @invoice2.reload
      @invoice3.reload
      @merchant2 = create(:merchant)

      expect(@merchant1.best_day.to_s).to eq(@invoice3.created_at.strftime("%Y-%m-%d"))
      expect(@merchant2.best_day).to be nil
    end
  end

end