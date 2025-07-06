# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Clear existing data
Subscriber.destroy_all

# Create sample subscribers
subscribers = [
  { name: "Rick Sanchez", email: "rickc137@citadel.com", status: "active" },
  { name: "Morty Smith", email: "morty.smith@gmail.com", status: "inactive" },
  { name: "Jerry Smith", email: "jerry.smith@aol.com", status: "active" },
  { name: "Beth Smith", email: "beth.smith@gmail.com", status: "active" },
  { name: "Summer Smith", email: "summer.smith@gmail.com", status: "active" },
  { name: "Bird Person", email: "bird.person@birdworld.com", status: "active" }
]

subscribers.each do |subscriber_data|
  Subscriber.create!(subscriber_data)
end

puts "Created #{Subscriber.count} subscribers"
