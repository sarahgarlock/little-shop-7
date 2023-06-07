require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many :items }
    it { should have_many(:invoice_items).through(:items)}
    it { should have_many(:invoices).through(:invoice_items)}
  end

  describe 'validations' do 
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:status) }
  end
  
  describe 'instance methods' do
    it 'items_ready_to_ship' do
      merchant1 = Merchant.create!(name: "Pen Inc.", status: 1)
      item1 = Item.create!(name: "pen ink", description: "xxxxxxx", unit_price: 10, merchant_id: merchant1.id)
      item2 = Item.create!(name: "printer ink", description: "xxxxxxx", unit_price: 11, merchant_id: merchant1.id)
      item3 = Item.create!(name: "pens", description: "xxxxxxx", unit_price: 12, merchant_id: merchant1.id)
      customer1 = Customer.create!(first_name: "Andy", last_name: "S")
      invoice1 = Invoice.create!(customer_id: customer1.id, status: 1, created_at: "2023-06-03 03:49:12.81835")
      invoice2 = Invoice.create!(customer_id: customer1.id, status: 1, created_at: "2023-06-02 03:49:12.81835")
      invoice3 = Invoice.create!(customer_id: customer1.id, status: 1, created_at: "2023-06-06 03:49:12.81835")
      transaction1 = invoice1.transactions.create!(cc_num: 1234567899876543, cc_exp: 9999999, result: 1)
      transaction2 = invoice2.transactions.create!(cc_num: 1234567899876543, cc_exp: 9999999, result: 1)
      transaction3 = invoice3.transactions.create!(cc_num: 1234567899876543, cc_exp: 9999999, result: 1)
      invoiceitem1 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, quantity: 100, unit_price: 10, status: 1)
      invoiceitem2 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice2.id, quantity: 100, unit_price: 10, status: 1)
      invoiceitem3 = InvoiceItem.create!(item_id: item3.id, invoice_id: invoice3.id, quantity: 100, unit_price: 10, status: 1)

      expect(merchant1.items_ready_to_ship).to eq([item1, item2, item3])
    end

    it 'update_status' do 
      merchant1 = Merchant.create!(name: "Pen Inc.", status: 1)
      item1 = Item.create!(name: "pen ink", description: "xxxxxxx", unit_price: 10, merchant_id: merchant1.id)
      item2 = Item.create!(name: "printer ink", description: "xxxxxxx", unit_price: 11, merchant_id: merchant1.id)
      item3 = Item.create!(name: "pens", description: "xxxxxxx", unit_price: 12, merchant_id: merchant1.id)
      customer1 = Customer.create!(first_name: "Andy", last_name: "S")
      invoice1 = Invoice.create!(customer_id: customer1.id, status: 1, created_at: "2023-06-03 03:49:12.81835")
      invoice2 = Invoice.create!(customer_id: customer1.id, status: 1, created_at: "2023-06-02 03:49:12.81835")
      invoice3 = Invoice.create!(customer_id: customer1.id, status: 1, created_at: "2023-06-06 03:49:12.81835")
      transaction1 = invoice1.transactions.create!(cc_num: 1234567899876543, cc_exp: 9999999, result: 1)
      transaction2 = invoice2.transactions.create!(cc_num: 1234567899876543, cc_exp: 9999999, result: 1)
      transaction3 = invoice3.transactions.create!(cc_num: 1234567899876543, cc_exp: 9999999, result: 1)
      invoiceitem1 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, quantity: 100, unit_price: 10, status: 1)
      invoiceitem2 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice2.id, quantity: 100, unit_price: 10, status: 1)
      invoiceitem3 = InvoiceItem.create!(item_id: item3.id, invoice_id: invoice3.id, quantity: 100, unit_price: 10, status: 1)

      expect(merchant1.status).to eq("disabled")

      merchant1.update_status("0")

      expect(merchant1.status).to eq("enabled")

      merchant1.update_status("1")

      expect(merchant1.status).to eq("disabled")

      expect(merchant1.update_status("foo")).to eq("invalid code")
    end

    it 'best_day' do 
      merchant1 = Merchant.create!(name: "Pen Inc.", status: 1)
      item1 = Item.create!(name: "pen ink", description: "xxxxxxx", unit_price: 10, merchant_id: merchant1.id)
      item2 = Item.create!(name: "printer ink", description: "xxxxxxx", unit_price: 11, merchant_id: merchant1.id)
      item3 = Item.create!(name: "pens", description: "xxxxxxx", unit_price: 12, merchant_id: merchant1.id)
      customer1 = Customer.create!(first_name: "Andy", last_name: "S")
      invoice1 = Invoice.create!(customer_id: customer1.id, status: 1, created_at: "2023-06-03 03:49:12.81835")
      invoice2 = Invoice.create!(customer_id: customer1.id, status: 1, created_at: "2023-06-02 03:49:12.81835")
      invoice3 = Invoice.create!(customer_id: customer1.id, status: 1, created_at: "2023-06-06 03:49:12.81835")
      transaction1 = invoice1.transactions.create!(cc_num: 1234567899876543, cc_exp: 9999999, result: 1)
      transaction2 = invoice2.transactions.create!(cc_num: 1234567899876543, cc_exp: 9999999, result: 1)
      transaction3 = invoice3.transactions.create!(cc_num: 1234567899876543, cc_exp: 9999999, result: 1)
      invoiceitem1 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, quantity: 100, unit_price: 10, status: 1)
      invoiceitem2 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice2.id, quantity: 100, unit_price: 10, status: 1)
      invoiceitem3 = InvoiceItem.create!(item_id: item3.id, invoice_id: invoice3.id, quantity: 100, unit_price: 10, status: 1)
      invoiceitem4 = InvoiceItem.create!(item_id: item3.id, invoice_id: invoice3.id, quantity: 100, unit_price: 10, status: 1)
      invoiceitem5 = InvoiceItem.create!(item_id: item3.id, invoice_id: invoice2.id, quantity: 100, unit_price: 10, status: 1)
      invoiceitem6 = InvoiceItem.create!(item_id: item3.id, invoice_id: invoice1.id, quantity: 100, unit_price: 10, status: 1)
      invoiceitem7 = InvoiceItem.create!(item_id: item3.id, invoice_id: invoice1.id, quantity: 100, unit_price: 10, status: 1)
      invoiceitem8 = InvoiceItem.create!(item_id: item3.id, invoice_id: invoice3.id, quantity: 100, unit_price: 10, status: 1)
      invoiceitem9 = InvoiceItem.create!(item_id: item3.id, invoice_id: invoice3.id, quantity: 100, unit_price: 10, status: 1)
      invoice1.reload
      invoice2.reload
      invoice3.reload
      merchant2 = create(:merchant)

      expect(merchant1.best_day.to_s).to eq(invoice3.created_at.strftime("%Y-%m-%d"))
      expect(merchant2.best_day).to be nil
    end

    describe '.top_by_revenue' do
      it 'returns the top 5 merchants by revenue' do
        merchant_1 = Merchant.create!(name: "Pen Inc.", status: 0)
        merchant_2 = Merchant.create!(name: "Dog Inc.", status: 0)
        merchant_3 = Merchant.create!(name: "Cat Inc.", status: 0)
        merchant_4 = Merchant.create!(name: "Bird Inc.", status: 0)
        merchant_5 = Merchant.create!(name: "Fish Inc.", status: 0)
        merchant_6 = Merchant.create!(name: "Lizard Inc.", status: 0)
        merchant_7 = Merchant.create!(name: "Izzard", status: 0)
        item_1 = Item.create!(name: "pen ink", description: "xxxxxxx", unit_price: 10, merchant_id: merchant_1.id)
        item_2 = Item.create!(name: "printer ink", description: "xxxxxxx", unit_price: 11, merchant_id: merchant_2.id)
        item_3 = Item.create!(name: "pens", description: "xxxxxxx", unit_price: 12, merchant_id: merchant_3.id)
        item_4 = Item.create!(name: "paperclip", description: "xxxxxxx", unit_price: 5, merchant_id: merchant_4.id)
        item_5 = Item.create!(name: "marker", description: "xxxxxxx", unit_price: 30, merchant_id: merchant_5.id)
        item_6 = Item.create!(name: "highlighter", description: "xxxxxxx", unit_price: 1, merchant_id: merchant_6.id)
        customer_1 = Customer.create!(first_name: "Andy", last_name: "S")
        invoice_1 = Invoice.create!(customer_id: customer_1.id, status: 1, created_at: "2023-06-03 03:49:12.81835")
        invoice_2 = Invoice.create!(customer_id: customer_1.id, status: 1, created_at: "2023-06-02 03:49:12.81835")
        invoice_3 = Invoice.create!(customer_id: customer_1.id, status: 1, created_at: "2023-06-06 03:49:12.81835")
        transaction_1 = invoice_1.transactions.create!(result: 1, cc_num: 1234567899876543, cc_exp: 9999999)
        transaction_2 = invoice_2.transactions.create!(result: 1, cc_num: 1234567899876543, cc_exp: 9999999)
        transaction_3 = invoice_3.transactions.create!(result: 1, cc_num: 1234567899876543, cc_exp: 9999999)
        invoiceitem_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 30, unit_price: 10, status: 1)
        invoiceitem_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_2.id, quantity: 100, unit_price: 10, status: 1)
        invoiceitem_3 = InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_3.id, quantity: 50, unit_price: 10, status: 1)
        invoiceitem_4 = InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_3.id, quantity: 170, unit_price: 10, status: 1)
        invoiceitem_5 = InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_2.id, quantity: 10, unit_price: 10, status: 1)
        invoiceitem_6 = InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_1.id, quantity: 20, unit_price: 10, status: 1)
        invoiceitem_7 = InvoiceItem.create!(item_id: item_4.id, invoice_id: invoice_1.id, quantity: 180, unit_price: 10, status: 1)
        invoiceitem_8 = InvoiceItem.create!(item_id: item_5.id, invoice_id: invoice_2.id, quantity: 40, unit_price: 10, status: 1)
        invoiceitem_9 = InvoiceItem.create!(item_id: item_6.id, invoice_id: invoice_3.id, quantity: 60, unit_price: 10, status: 1)
        
        merchants = Merchant.top_by_revenue(5)

        expect(merchants).to eq([merchant_3, merchant_4, merchant_2, merchant_6, merchant_5])
        expect(merchants).to_not include([merchant_1])
      end
    end

    it "#total_revenue" do 
      merchant_1 = Merchant.create!(name: "Pen Inc.", status: 0)
      merchant_2 = Merchant.create!(name: "Dog Inc.", status: 0)
      merchant_3 = Merchant.create!(name: "Cat Inc.", status: 0)
      merchant_4 = Merchant.create!(name: "Bird Inc.", status: 0)
      merchant_5 = Merchant.create!(name: "Fish Inc.", status: 0)
      merchant_6 = Merchant.create!(name: "Lizard Inc.", status: 0)
      merchant_7 = Merchant.create!(name: "Izzard", status: 0)
      item_1 = Item.create!(name: "pen ink", description: "xxxxxxx", unit_price: 10, merchant_id: merchant_1.id)
      item_2 = Item.create!(name: "printer ink", description: "xxxxxxx", unit_price: 11, merchant_id: merchant_2.id)
      item_3 = Item.create!(name: "pens", description: "xxxxxxx", unit_price: 12, merchant_id: merchant_3.id)
      item_4 = Item.create!(name: "paperclip", description: "xxxxxxx", unit_price: 5, merchant_id: merchant_4.id)
      item_5 = Item.create!(name: "marker", description: "xxxxxxx", unit_price: 30, merchant_id: merchant_5.id)
      item_6 = Item.create!(name: "highlighter", description: "xxxxxxx", unit_price: 1, merchant_id: merchant_6.id)
      customer_1 = Customer.create!(first_name: "Andy", last_name: "S")
      invoice_1 = Invoice.create!(customer_id: customer_1.id, status: 1, created_at: "2023-06-03 03:49:12.81835")
      invoice_2 = Invoice.create!(customer_id: customer_1.id, status: 1, created_at: "2023-06-02 03:49:12.81835")
      invoice_3 = Invoice.create!(customer_id: customer_1.id, status: 1, created_at: "2023-06-06 03:49:12.81835")
      transaction_1 = invoice_1.transactions.create!(result: 1, cc_num: 1234567899876543, cc_exp: 9999999)
      transaction_2 = invoice_2.transactions.create!(result: 1, cc_num: 1234567899876543, cc_exp: 9999999)
      transaction_3 = invoice_3.transactions.create!(result: 1, cc_num: 1234567899876543, cc_exp: 9999999)
      invoiceitem_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 30, unit_price: 10, status: 1)
      invoiceitem_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_2.id, quantity: 100, unit_price: 10, status: 1)
      invoiceitem_3 = InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_3.id, quantity: 50, unit_price: 10, status: 1)
      invoiceitem_4 = InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_3.id, quantity: 170, unit_price: 10, status: 1)
      invoiceitem_5 = InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_2.id, quantity: 10, unit_price: 10, status: 1)
      invoiceitem_6 = InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_1.id, quantity: 20, unit_price: 10, status: 1)
      invoiceitem_7 = InvoiceItem.create!(item_id: item_4.id, invoice_id: invoice_1.id, quantity: 180, unit_price: 10, status: 1)
      invoiceitem_8 = InvoiceItem.create!(item_id: item_5.id, invoice_id: invoice_2.id, quantity: 40, unit_price: 10, status: 1)
      invoiceitem_9 = InvoiceItem.create!(item_id: item_6.id, invoice_id: invoice_3.id, quantity: 60, unit_price: 10, status: 1)

      expect(merchant_1.total_revenue).to eq(300)
      expect(merchant_2.total_revenue).to eq(1000)
      expect(merchant_3.total_revenue).to eq(2500)
      expect(merchant_4.total_revenue).to eq(1800)
    end
  end
end