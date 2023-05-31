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
end

