require 'rails_helper'

RSpec.describe 'Merchant Items', type: :feature do
  describe "merchant items index" do
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

    # 6. Merchant Items Index Page
    it "lists items by merchant" do
      visit "/merchants/#{@merchant1.id}/items"
      expect(page).to have_content(@merchant1.name)

      within "#merchants_items" do
        expect(page).to have_content(@item1.name)
        expect(page).to have_content(@item2.name)
        expect(page).to have_content(@item3.name)

        expect(page).to_not have_content(@merchant2.name)
        expect(page).to_not have_content(@item4.name)
      end
    end

    # 7. Merchant Items Show Page
    it "links to item show page" do
      visit "/merchants/#{@merchant1.id}/items"

      within "#merchants_items" do
        expect(page).to have_link "#{@item1.name}"
        expect(page).to have_link "#{@item2.name}"
        expect(page).to have_link "#{@item3.name}"

        click_link "#{@item1.name}"
        expect(current_path).to eq("/merchants/#{@merchant1.id}/items/#{@item1.id}")
      end
    end
    
#   9.  Merchant Item Disable/Enable
    it "has a button to disable or enable an item" do 
      visit "/merchants/#{@merchant1.id}/items"

      within "#merchants_items-#{@item1.id}" do
        expect(page).to have_content("#{@item1.name} Status: enabled")
        expect(page).to have_button("Disable Item")
        click_button "Disable Item"
      end
      
      within "#merchants_items-#{@item1.id}" do
        expect(current_path).to eq("/merchants/#{@merchant1.id}/items")
        expect(page).to have_content("#{@item1.name} Status: disabled")
        expect(page).to have_button("Enable Item")
      end
    end

    # 10. Merchant Items Grouped by Status
    it "has sections for enabled and disabled items" do
      visit "/merchants/#{@merchant1.id}/items"

      within "#enabled" do
        expect(page).to have_content(@item1.name)
        expect(page).to have_content(@item2.name)
        expect(page).to_not have_content(@item3.name)
      end

      within "#disabled" do
        expect(page).to_not have_content(@item1.name)
        expect(page).to_not have_content(@item2.name)
        expect(page).to have_content(@item3.name)
      end
    end

    # 11. Merchant Item Create
    it "can add new items" do 
      visit "/merchants/#{@merchant1.id}/items"

      expect(page).to have_link "Create new item"
      click_link "Create new item"
    end


    # 12. Merchant Items Index: 5 most popular items
    it "shows popular items for the merchant" do
      visit "/merchants/#{@merchant1.id}/items"

      within "#popular-items" do
        expect(@item5.name).to appear_before(@item3.name)
        expect(@item3.name).to appear_before(@item2.name)
        expect(@item2.name).to appear_before(@item1.name)
        expect(@item1.name).to appear_before(@item6.name)

        expect(page).to have_link "#{@item5.name}"
        expect(page).to have_link "#{@item3.name}"
        expect(page).to have_link "#{@item2.name}"
        expect(page).to have_link "#{@item1.name}"
        expect(page).to have_link "#{@item6.name}"
      
        expect(@item5.item_rev_dollars).to eq(1500)
        expect(@item3.item_rev_dollars).to eq(1200)
        expect(@item2.item_rev_dollars).to eq(1100)
        expect(@item1.item_rev_dollars).to eq(1000)
        expect(@item6.item_rev_dollars).to eq(100)

        click_link "#{@item1.name}"
        expect(current_path).to eq("/merchants/#{@merchant1.id}/items/#{@item1.id}")
      end
    end

    # 13.  Merchant Items Index: Top Item's Best Day
    it "can add new items" do 
      visit "/merchants/#{@merchant1.id}/items"
      
      within "#popular-items" do
        expect(page).to have_content(@item5.best_day)
        expect(page).to have_content(@item3.best_day)
        expect(page).to have_content(@item2.best_day)
        expect(page).to have_content(@item1.best_day)
        expect(page).to have_content(@item6.best_day)

        expect(@item5.best_day).to eq(Date.today)
        expect(@item3.best_day).to eq(Date.today)
        expect(@item2.best_day).to eq(Date.today)
        expect(@item1.best_day).to eq(Date.today)
        expect(@item6.best_day).to eq(Date.today)
      end
    end  
  end
end
