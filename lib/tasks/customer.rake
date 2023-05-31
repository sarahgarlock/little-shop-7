desc "Import data from CSV file to the database"
task :csv_load, [:customers]  do
  require 'csv'

  csv_file = "customers.csv"

  puts "Importing data from #{csv_file}..."

  CSV.foreach(csv_file, headers: true) do |row|
    Customer.create(first_name: row['first_name'], last_name: row['last_name'])
  end

  puts "Data imported successfully!"
end
