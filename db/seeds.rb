# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.create! email: 'roxas.shadow@hotmail.it', password: 'lolwut', created_at: 2.years.ago

paypal   = user.accounts.create! name: 'PayPal',   money: 180.45,  created_at: 2.years.ago
bancomat = user.accounts.create! name: 'Bancomat', money: 2500.00, created_at: 2.years.ago
wallet   = user.accounts.create! name: 'Wallet',   money: 200.00,  created_at: 3.months.ago

paypal.items.create! name: 'Pokémon X',      price: 45.00, created_at: 2.months.ago
paypal.items.create! name: 'Child of Light', price: 22.90, details: 'PC', created_at: 2.months.ago
paypal.items.create! name: 'Steins;Gate v1', price: 36.90, details: 'BD', created_at: 1.month.ago

bancomat.items.create! name: 'Intel Core i7 4670k', price: 220.90, created_at: 10.days.ago
bancomat.items.create! name: 'AMD Sapphire 280x',   price: 170.00, created_at: 10.days.ago
bancomat.items.create! name: 'The world',           price: 699.99, quantity: 99, created_at: 1000.years.ago

[3.days.ago, 0.days.ago].each do |date|
  wallet.items.create! name: 'Bread',   price: 1.00, quantity: 10, created_at: date
  wallet.items.create! name: 'Water',   price: 1.50, quantity: 5,  created_at: date
  wallet.items.create! name: 'Cookies', price: 2.30, quantity: 3,  created_at: date
end

wallet.items.create! name: 'Apple',  price: 1.00, quantity: 4,  created_at: 1.day.ago
wallet.items.create! name: 'Kiwi',   price: 1.50, quantity: 5,  created_at: 1.day.ago
wallet.items.create! name: 'Tomato', price: 0.90, quantity: 2,  created_at: 1.day.ago