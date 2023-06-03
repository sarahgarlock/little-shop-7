require 'rails_helper'

RSpec.describe Merchant, type: :model do
  before :each do
    @merchant1 = Merchant.create!(name: "Pen Inc.")
    @item1 = Item.create!(name: "pen ink", description: "xxxxxxx", unit_price: 10, merchant_id: @merchant1.id)
    @item2 = Item.create!(name: "printer ink", description: "xxxxxxx", unit_price: 11, merchant_id: @merchant1.id)
    @item3 = Item.create!(name: "pens", description: "xxxxxxx", unit_price: 12, merchant_id: @merchant1.id)
    @customer1 = Customer.create!(first_name: "Andy", last_name: "S")
    @invoice1 = Invoice.create!(customer_id: @customer1.id, status: 1)
    @invoice2 = Invoice.create!(customer_id: @customer1.id, status: 1)
    @invoice3 = Invoice.create!(customer_id: @customer1.id, status: 1)
    @invoiceitem1 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 100, unit_price: 10, status: 1)
    @invoiceitem2 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice2.id, quantity: 100, unit_price: 10, status: 1)
    @invoiceitem3 = InvoiceItem.create!(item_id: @item3.id, invoice_id: @invoice3.id, quantity: 100, unit_price: 10, status: 1)
  end
  describe 'relationships' do
    it { should have_many :items }
    it { should have_many(:invoice_items).through(:items)}
  end

  describe 'class methods' do
    it 'items_ready_to_ship' do
      expect(@merchant1.items_ready_to_ship).to eq([@item1, @item2, @item3])
    end
  end
end