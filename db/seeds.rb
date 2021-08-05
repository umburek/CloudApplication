# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
5.times do |i|
  user = User.create(email: "user-#{i}@example.com", password: 'Secret99')

  5.times { |i| Quote.create(label: "Word #{i}", user: user, score: i + 1) }
end
