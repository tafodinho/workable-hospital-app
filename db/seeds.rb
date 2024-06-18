# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'date'
require 'json'
require_relative "../config/environment"
require 'faker'

User.create(
  email: "user@user.com",
  password: "Hacker@111",
  role: 1
)

User.create(
  email: "admin@admin.com",
  password: "Hacker@111",
  role: 0
)

User.create(
  email: "tafodinho@gmail.com.com",
  password: "Hacker@111",
  role: 2
)


# Get today's date and time

# Generate an array of dates for the past 2 years
def generate_dates_for_past_two_years
  today = Date.today
  (0..(2 * 365)).map { |i| today - i }
end

# Generate random number of patients between 0 and 20 for each date
def generate_patient_data(dates)
  random = Random.new
  dates.each do |date|
    random.rand(0..20).times do 
      Patient.create(
        name: Faker::Name.name,
        email: Faker::Internet.email,
        phone_number: Faker::Number.number,
        address: Faker::Address.full_address,
        dob: Faker::Date.birthday(min_age: 18, max_age: 65),
        created_at: date,
        updated_at: date,
      )
    end
   end
end

generate_patient_data(generate_dates_for_past_two_years())

