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