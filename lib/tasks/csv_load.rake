namespace :csv_load do
  desc "Import data from customers CSV file to the database"
  task customers: :environment do
    require 'csv'

    ActiveRecord::Base.connection.reset_pk_sequence!('customers')

    csv_file = "lib/seeds/customers.csv"

    puts "Importing data from #{csv_file}..."

    CSV.foreach(csv_file, headers: true) do |row|
      Customer.create(id: row['id'], first_name: row['first_name'], last_name: row['last_name'])
    end

    puts "Data imported successfully!"
  end

  desc "Import data from merchants CSV file to the database"
  task merchants: :environment do
    require 'csv'

    ActiveRecord::Base.connection.reset_pk_sequence!('merchants')

    csv_file = "lib/seeds/merchants.csv"

    puts "Importing data from #{csv_file}..."

    CSV.foreach(csv_file, headers: true) do |row|
      Merchant.create(id: row['id'], name: row['name'])
    end

    puts "Data imported successfully!"
  end

  desc "Import data from items CSV file to the database"
  task items: :environment do
    require 'csv'

    ActiveRecord::Base.connection.reset_pk_sequence!('items')

    csv_file = "lib/seeds/items.csv"

    puts "Importing data from #{csv_file}..."

    CSV.foreach(csv_file, headers: true) do |row|
      Item.create(id: row['id'], 
                  name: row['name'], 
                  description: row['description'], 
                  unit_price: row['unit_price'], 
                  merchant_id: row['merchant_id'])
    end

    puts "Data imported successfully!"
  end

  desc "Import data from transactions CSV file to the database"
  task transactions: :environment do
    require 'csv'
  
    ActiveRecord::Base.connection.reset_pk_sequence!('transactions')
  
    csv_file = "lib/seeds/transactions.csv"
  
    puts "Importing data from #{csv_file}..."
  
    CSV.foreach(csv_file, headers: true) do |row|
      Transaction.create(id: row['id'], 
                  cc_num: row['credit_card_number'], 
                  cc_exp: row['credit_card_expiration_date'],
                  result: row['result'],
                  invoice_id: row['invoice_id'])
    end
  
    puts "Data imported successfully!"
  end

  desc "Import data from invoices CSV file to the database"
  task invoices: :environment do
    require 'csv'
  
    ActiveRecord::Base.connection.reset_pk_sequence!('invoices')
  
    csv_file = "lib/seeds/invoices.csv"
  
    puts "Importing data from #{csv_file}..."
  
    CSV.foreach(csv_file, headers: true) do |row|
      Invoice.create(id: row['id'], 
                  status: row['status'], 
                  customer_id: row['customer_id'])
    end
  
    puts "Data imported successfully!"
  end

  desc "Import data from invoice_items CSV file to the database"
  task invoice_items: :environment do
    require 'csv'
  
    ActiveRecord::Base.connection.reset_pk_sequence!('invoice_items')
  
    csv_file = "lib/seeds/invoice_items.csv"
  
    puts "Importing data from #{csv_file}..."
  
    CSV.foreach(csv_file, headers: true) do |row|
      InvoiceItem.create(id: row['id'], 
                  quantity: row['quantity'], 
                  unit_price: row['unit_price'], 
                  status: row['status'], 
                  invoice_id: row['invoice_id'],
                  item_id: row['item_id'])
    end
  
    puts "Data imported successfully!"
  end

  desc "Import data from all CSV file to the database"
  task all: [:customers, :merchants, :items, :transactions, :invoices, :invoice_items]  do
    require 'csv'
  
    puts "All data imported successfully!"
  end
end

