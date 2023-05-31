# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require "csv"

csv_customers = File.read(Rails.root.join('lib', 'seeds', 'customers.csv'))
csv_invoice_items = File.read(Rails.root.join('lib', 'seeds', 'invoice_items.csv'))
csv_invoices = File.read(Rails.root.join('lib', 'seeds', 'invoices.csv'))
csv_items = File.read(Rails.root.join('lib', 'seeds', 'items.csv'))
csv_merchants = File.read(Rails.root.join('lib', 'seeds', 'merchants.csv'))
csv_transactions = File.read(Rails.root.join('lib', 'seeds', 'transactions.csv'))

puts csv_customers
puts csv_invoice_items
puts csv_invoices
puts csv_items
puts csv_merchants
puts csv_transactions

