# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require Rails.root.join('lib/build/database_builder.rb')
# Build::DatabaseBuilder.run
@user=User.create(
            first_name: "Nikhil",
            last_name: "Gosavi", 
            age: 22,
            date_of_birth: Faker::Date.birthday(min_age: 18, max_age: 65),
            email: "nikhil19@gmail.com",
            password: "nikhil18",
            role_type: 2
        )

# tags = [
#   "Fiction", "Science Fiction", "Mystery", "Fantasy",
#   "Romance", "History", "Biography", "Self-Help",
#   "Cooking", "Travel", "Art", "Health", "Science",
#   "Technology", "Business", "Finance", "Education",
#   "Sports", "Music", "Nature"
# ]

# tags.each { |tag| Tag.create(name: tag) }

# 5.times do |index|
#   Book.create!(name: Faker::Name.name,
#         description: Faker::Lorem.words(number: rand(10..20)).join(' '),
#         number_of_copy: Faker::Number.within(range: 1..20),
#         status: :available,
#         user_id: @user.id,
#         note: Faker::Lorem.words(number: rand(2..10)).join(' '),
#         likes: Faker::Number.within(range: 1..20))

#   Book.create!(name: Faker::Name.name,
#         description: Faker::Lorem.words(number: rand(10..20)).join(' '),
#         number_of_copy: Faker::Number.within(range: 1..20),
#         status: :not_available,
#         user_id: @user.id,
#         note: Faker::Lorem.words(number: rand(2..10)).join(' '),
#         likes: Faker::Number.within(range: 1..20))

#   Book.create!(name: Faker::Name.name,
#         description: Faker::Lorem.words(number: rand(10..20)).join(' '),
#         number_of_copy: Faker::Number.within(range: 1..20),
#         status: :archived,
#         user_id: @user.id,
#         note: Faker::Lorem.words(number: rand(2..10)).join(' '),
#         likes: Faker::Number.within(range: 1..20))
# end