require "rails_helper" 

RSpec.describe "Admin Merchant Index", type: :feature do 
  before(:each) do 
    @merchant = create_list(:merchant, 4)
    @item1 = Item.create!(name: "pen ink", description: "xxxxxxx", unit_price: 10, merchant_id: @merchant[0].id)
    @item2 = Item.create!(name: "printer ink", description: "xxxxxxx", unit_price: 11, merchant_id: @merchant[0].id)
    @item3 = Item.create!(name: "pens", description: "xxxxxxx", unit_price: 12, merchant_id: @merchant[0].id)
    @item4 = Item.create!(name: "paperclip", description: "xxxxxxx", unit_price: 5, merchant_id: @merchant[1].id)
    @item5 = Item.create!(name: "marker", description: "xxxxxxx", unit_price: 30, merchant_id: @merchant[2].id)
    @item6 = Item.create!(name: "highlighter", description: "xxxxxxx", unit_price: 1, merchant_id: @merchant[3].id)
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
    @invoiceitem4 = InvoiceItem.create!(item_id: @item3.id, invoice_id: @invoice3.id, quantity: 100, unit_price: 10, status: 1)
    @invoiceitem5 = InvoiceItem.create!(item_id: @item3.id, invoice_id: @invoice2.id, quantity: 100, unit_price: 10, status: 1)
    @invoiceitem6 = InvoiceItem.create!(item_id: @item3.id, invoice_id: @invoice1.id, quantity: 100, unit_price: 10, status: 1)
    @invoiceitem7 = InvoiceItem.create!(item_id: @item4.id, invoice_id: @invoice1.id, quantity: 100, unit_price: 10, status: 1)
    @invoiceitem8 = InvoiceItem.create!(item_id: @item5.id, invoice_id: @invoice2.id, quantity: 100, unit_price: 10, status: 1)
    @invoiceitem9 = InvoiceItem.create!(item_id: @item6.id, invoice_id: @invoice3.id, quantity: 100, unit_price: 10, status: 1)
    @merch_1 = create(:merchant)    
    @merch_2 = create(:merchant)
    @merch_3 = create(:merchant)
    @merch_4 = create(:merchant)
    @merch_5 = create(:merchant)
    @merch_6 = create(:merchant)

    @item_1 = create(:item, merchant: @merch_1)
    @item_2 = create(:item, merchant: @merch_2)
    @item_3 = create(:item, merchant: @merch_3)
    @item_4 = create(:item, merchant: @merch_4)
    @item_5 = create(:item, merchant: @merch_5)
    @item_6 = create(:item, merchant: @merch_6)

    @invoice_1 = create(:invoice)
    @invoice_2 = create(:invoice)
    @invoice_3 = create(:invoice)

    @invoice_item_1 = create(:invoice_item, invoice: @invoice_1, item: @item_1, quantity: 20, unit_price: 500)
    @invoice_item_2 = create(:invoice_item, invoice: @invoice_1, item: @item_2, quantity: 18, unit_price: 500)
    @invoice_item_3 = create(:invoice_item, invoice: @invoice_1, item: @item_3, quantity: 16, unit_price: 500)
    @invoice_item_4 = create(:invoice_item, invoice: @invoice_2, item: @item_4, quantity: 14, unit_price: 500)
    @invoice_item_5 = create(:invoice_item, invoice: @invoice_2, item: @item_5, quantity: 12, unit_price: 500)
    @invoice_item_6 = create(:invoice_item, invoice: @invoice_2, item: @item_6, quantity: 10, unit_price: 500)
    @invoice_item_7 = create(:invoice_item, invoice: @invoice_3, item: @item_1, quantity: 8, unit_price: 500)
    @invoice_item_8 = create(:invoice_item, invoice: @invoice_3, item: @item_2, quantity: 7, unit_price: 500)
    @invoice_item_9 = create(:invoice_item, invoice: @invoice_3, item: @item_3, quantity: 6, unit_price: 500)
    @invoice_item_10 = create(:invoice_item, invoice: @invoice_3, item: @item_4, quantity: 5, unit_price: 500)
    @invoice_item_11 = create(:invoice_item, invoice: @invoice_3, item: @item_5, quantity: 40, unit_price: 500)
    @invoice_item_12 = create(:invoice_item, invoice: @invoice_3, item: @item_6, quantity: 25, unit_price: 500)
    @invoice_item_13 = create(:invoice_item, invoice: @invoice_3, item: @item_1, quantity: 20, unit_price: 500)
    @invoice_item_14 = create(:invoice_item, invoice: @invoice_3, item: @item_2, quantity: 18, unit_price: 500)
    @invoice_item_15 = create(:invoice_item, invoice: @invoice_3, item: @item_3, quantity: 16, unit_price: 500)

    @transaction1 = create(:transaction, invoice: @invoice_1, result: 0)
    @transaction2 = create(:transaction, invoice: @invoice_2, result: 0)
    @transaction3 = create(:transaction, invoice: @invoice_3, result: 0)
    # result: {success: 0, failed: 1}

  end

  it "links to merchant show page" do 
    visit admin_merchants_path
    
    within("#merchant-#{@merchant[0].id}") do 
      click_link "#{@merchant[0].name}"
    end
    
    expect(current_path).to eq("/admin/merchants/#{@merchant[0].id}")
  end
  
  it "has buttons to disable or enable each merchant" do 
    visit admin_merchants_path

    within("#merchant-#{@merchant[0].id}") do 
      expect(page).to have_content("disabled")
    end
    
    within("#merchant-#{@merchant[1].id}") do 
      expect(page).to have_content("#{@merchant[1].status}")
    end
    
    expect(page).to have_button("Disable #{@merchant[0].name}")
    expect(page).to have_button("Disable #{@merchant[1].name}")
    expect(page).to have_button("Disable #{@merchant[2].name}")
    expect(page).to have_button("Disable #{@merchant[3].name}")
    expect(page).to have_button("Enable #{@merchant[3].name}")
    expect(page).to have_button("Enable #{@merchant[2].name}")
    expect(page).to have_button("Enable #{@merchant[1].name}")
    expect(page).to have_button("Enable #{@merchant[0].name}")
    click_button "Enable #{@merchant[0].name}"
    
    expect(current_path).to eq(admin_merchants_path)
    
    within("#merchant-#{@merchant[0].id}") do 
      expect(page).to have_content("enabled")
    end

    click_button "Disable #{@merchant[0].name}"
    
    expect(current_path).to eq(admin_merchants_path)
    
    within("#merchant-#{@merchant[0].id}") do 
      expect(page).to have_content("disabled")
    end
  end

  it "displays merchants separated by status" do 
    @merchant[0].disabled!
    @merchant[1].disabled!
    @merchant[2].enabled!
    @merchant[3].enabled!

    visit admin_merchants_path

    within("#merchants-enabled") do 
      expect(page).to have_content("#{@merchant[2].name}")
      expect(page).to have_content("#{@merchant[3].name}")
    end


    within("#merchants-disabled") do 
      expect(page).to have_content("#{@merchant[0].name}")
      expect(page).to have_content("#{@merchant[1].name}")
    end
  end

  it "has a link to create a new merchant" do
    visit admin_merchants_path

    click_link "Create a New Merchant" 

    expect(current_path).to eq("/admin/merchants/new")
  end

  it "displays the names of the top 5 merchants by total revenue generated" do
    visit admin_merchants_path
    within("#top-merchants") do
      save_and_open_page
      expect(page).to have_content("#{@merch_5.name} - $198,000.00 revenue")
      expect(page).to have_content("#{@merch_1.name} - $156,000.00 revenue")
      expect(page).to have_content("#{@merch_2.name} - $139,500.00 revenue")
      expect(page).to have_content("#{@merch_3.name} - $127,500.00 revenue")
      expect(page).to have_content("#{@merch_6.name} - $123,000.00 revenue")

      expect(page).to_not have_content("#{@merch_4.name} - $9.50 revenue")
    end
    click_link @merch_5.name
    expect(current_path).to eq(admin_merchant_path(@merch_5))
    
    click_link merch_1.name
    expect(current_path).to eq(admin_merchant_path(@merch_1))
    
    click_link merch_2.name
    expect(current_path).to eq(admin_merchant_path(@merch_2))
    
    click_link merch_3.name
    expect(current_path).to eq(admin_merchant_path(@merch_3))
    
    click_link merch_6.name
    expect(current_path).to eq(admin_merchant_path(@merch_6))
  end

  it "lists the top selling date for each of the top 5 merchants" do 
    visit admin_merchants_path

    within("#merchant-best-#{@merchant[0].id}") do 
      expect(page).to have_content(@merchant[0].best_day)
    end

    within("#merchant-best-#{@merchant[1].id}") do 
      expect(page).to have_content(@merchant[1].best_day)
    end

    within("#merchant-best-#{@merchant[2].id}") do 
      expect(page).to have_content(@merchant[2].best_day)
    end

    expect(page).to have_content("Top 5 Merchants by Revenue")
  end
end

# 30. Admin Merchants: Top 5 Merchants by Revenue

# As an admin,
# When I visit the admin merchants index (/admin/merchants)
# Then I see the names of the top 5 merchants by total revenue generated
# And I see that each merchant name links to the admin merchant show page for that merchant
# And I see the total revenue generated next to each merchant name

# Notes on Revenue Calculation:
# - Only invoices with at least one successful transaction should count towards revenue
# - Revenue for an invoice should be calculated as the sum of the revenue of all invoice items
# - Revenue for an invoice item should be calculated as the invoice item unit price multiplied by the quantity (do not use the item unit price)