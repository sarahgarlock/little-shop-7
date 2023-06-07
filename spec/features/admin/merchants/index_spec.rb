require "rails_helper" 

RSpec.describe "Admin Merchant Index", type: :feature do 
  before(:each) do 
    
    @merchant_1 = Merchant.create!(name: "Pen Inc.", status: 0)
    @merchant_2 = Merchant.create!(name: "Dog Inc.", status: 0)
    @merchant_3 = Merchant.create!(name: "Cat Inc.", status: 0)
    @merchant_4 = Merchant.create!(name: "Bird Inc.", status: 0)
    @merchant_5 = Merchant.create!(name: "Fish Inc.", status: 0)
    @merchant_6 = Merchant.create!(name: "Lizard Inc.", status: 0)
    @item_1 = Item.create!(name: "pen ink", description: "xxxxxxx", unit_price: 10, merchant_id: @merchant_1.id)
    @item_2 = Item.create!(name: "printer ink", description: "xxxxxxx", unit_price: 11, merchant_id: @merchant_2.id)
    @item_3 = Item.create!(name: "pens", description: "xxxxxxx", unit_price: 12, merchant_id: @merchant_3.id)
    @item_4 = Item.create!(name: "paperclip", description: "xxxxxxx", unit_price: 5, merchant_id: @merchant_4.id)
    @item_5 = Item.create!(name: "marker", description: "xxxxxxx", unit_price: 30, merchant_id: @merchant_5.id)
    @item_6 = Item.create!(name: "highlighter", description: "xxxxxxx", unit_price: 1, merchant_id: @merchant_6.id)
    @customer_1 = Customer.create!(first_name: "Andy", last_name: "S")
    @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 1, created_at: "2023-06-03 03:49:12.81835")
    @invoice_2 = Invoice.create!(customer_id: @customer_1.id, status: 1, created_at: "2023-06-02 03:49:12.81835")
    @invoice_3 = Invoice.create!(customer_id: @customer_1.id, status: 1, created_at: "2023-06-06 03:49:12.81835")
    @transaction_1 = @invoice_1.transactions.create!(result: 1, cc_num: 1111111111111111, cc_exp: 1111)
    @transaction_2 = @invoice_2.transactions.create!(result: 1, cc_num: 1111111111111111, cc_exp: 1111)
    @transaction_3 = @invoice_3.transactions.create!(result: 1, cc_num: 1111111111111111, cc_exp: 1111)
    @invoiceitem_1 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_1.id, quantity: 30, unit_price: 10, status: 1)
    @invoiceitem_2 = InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_2.id, quantity: 100, unit_price: 10, status: 1)
    @invoiceitem_3 = InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice_3.id, quantity: 50, unit_price: 10, status: 1)
    @invoiceitem_4 = InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice_3.id, quantity: 170, unit_price: 10, status: 1)
    @invoiceitem_5 = InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice_2.id, quantity: 10, unit_price: 10, status: 1)
    @invoiceitem_6 = InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice_1.id, quantity: 20, unit_price: 10, status: 1)
    @invoiceitem_7 = InvoiceItem.create!(item_id: @item_4.id, invoice_id: @invoice_1.id, quantity: 180, unit_price: 10, status: 1)
    @invoiceitem_8 = InvoiceItem.create!(item_id: @item_5.id, invoice_id: @invoice_2.id, quantity: 40, unit_price: 10, status: 1)
    @invoiceitem_9 = InvoiceItem.create!(item_id: @item_6.id, invoice_id: @invoice_3.id, quantity: 60, unit_price: 10, status: 1)

  end

  describe "As an admin, when I visit the admin merchants index" do
    it "links to merchant show page" do 
      visit admin_merchants_path
      
      within("#merchant-#{@merchant_1.id}") do 
        click_link "#{@merchant_1.name}"
      end
      
      expect(current_path).to eq("/admin/merchants/#{@merchant_1.id}")
    end
    
    it "has buttons to disable or enable each merchant" do 
      visit admin_merchants_path

      within("#merchant-#{@merchant_1.id}") do 
        expect(page).to have_content("enabled")
      end
      
      within("#merchant-#{@merchant_2.id}") do 
        expect(page).to have_content("#{@merchant_2.status}")
      end
      
      expect(page).to have_button("Disable #{@merchant_1.name}")
      expect(page).to have_button("Disable #{@merchant_2.name}")
      expect(page).to have_button("Disable #{@merchant_3.name}")
      expect(page).to have_button("Disable #{@merchant_4.name}")
      expect(page).to have_button("Enable #{@merchant_4.name}")
      expect(page).to have_button("Enable #{@merchant_3.name}")
      expect(page).to have_button("Enable #{@merchant_2.name}")
      expect(page).to have_button("Enable #{@merchant_1.name}")

      within("#merchant-#{@merchant_1.id}") do
        click_button "Disable #{@merchant_1.name}"
      end
      
      
      expect(current_path).to eq(admin_merchants_path)
      
      within("#merchant-#{@merchant_1.id}") do 
        expect(page).to have_content("disabled")

      end

      within("#merchant-#{@merchant_1.id}") do
        click_button "Enable #{@merchant_1.name}"
      end
      
      expect(current_path).to eq(admin_merchants_path)
      
      within("#merchant-#{@merchant_1.id}") do 
        expect(page).to have_content("enabled")
      end
    end

    it "displays merchants separated by status" do 
      @merchant_1.disabled!
      @merchant_2.disabled!
      @merchant_3.enabled!
      @merchant_4.enabled!

      visit admin_merchants_path

      within("#merchants-enabled") do 
        expect(page).to have_content("#{@merchant_3.name}")
        expect(page).to have_content("#{@merchant_4.name}")
      end


      within("#merchants-disabled") do 
        expect(page).to have_content("#{@merchant_1.name}")
        expect(page).to have_content("#{@merchant_2.name}")
      end
    end

    it "has a link to create a new merchant" do
      visit admin_merchants_path

      click_link "Create a New Merchant" 

      expect(current_path).to eq("/admin/merchants/new")
    end

    it "lists the top selling date for each of the top 5 merchants" do 
      visit admin_merchants_path
  
      within("#merchant-best-#{@merchant_4.id}") do 
        expect(page).to have_content(@merchant_4.best_day)
      end
  
      within("#merchant-best-#{@merchant_2.id}") do 
        expect(page).to have_content(@merchant_2.best_day)
      end
  
      within("#merchant-best-#{@merchant_3.id}") do 
        expect(page).to have_content(@merchant_3.best_day)
      end
  
      expect(page).to have_content("Top 5 Merchants by Revenue")
    end

    it "shows top 5 merchants by total revenue generated" do
      visit admin_merchants_path

      within("#top-5") do 
        expect("#{@merchant_3.name}").to appear_before("#{@merchant_4.name}")
        expect("#{@merchant_4.name}").to appear_before("#{@merchant_2.name}")
        expect("#{@merchant_2.name}").to appear_before("#{@merchant_6.name}")
        expect("#{@merchant_6.name}").to appear_before("#{@merchant_5.name}")
        expect(page).to_not have_content("#{@merchant_1.name}")
        
        expect(page).to have_link("#{@merchant_3.name}")
        expect(page).to have_link("#{@merchant_4.name}")
        expect(page).to have_link("#{@merchant_2.name}")
        expect(page).to have_link("#{@merchant_6.name}")
        expect(page).to have_link("#{@merchant_5.name}")
        expect(page).to_not have_link("#{@merchant_1.name}")

        expect(@merchant_3.total_revenue).to eq(2500)
        expect(page).to have_content("Total Revenue: $25.00")
        expect(@merchant_4.total_revenue).to eq(1800)
        expect(page).to have_content("Total Revenue: $18.00")
        expect(@merchant_2.total_revenue).to eq(1000)
        expect(page).to have_content("Total Revenue: $10.00")
        expect(@merchant_6.total_revenue).to eq(600)
        expect(page).to have_content("Total Revenue: $6.00")
        expect(@merchant_5.total_revenue).to eq(400)
        expect(page).to have_content("Total Revenue: $4.00")
        
        click_link "#{@merchant_3.name}"
        expect(current_path).to eq("/admin/merchants/#{@merchant_3.id}")

        merchants = Merchant.top_by_revenue(5)
        expect(merchants).to eq([@merchant_3, @merchant_4, @merchant_2, @merchant_6, @merchant_5])
      end
    end
  end
end