# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(name: "Patrick Cartlidge", email: "patrickcartlidge@gmail.com", password: "password", password_confirmation: "password", role: "admin", trainer: false)
User.create(name: "Patrick Bartlidge", email: "patrickbartlidge@gmail.com", password: "password", password_confirmation: "password", role: "admin", trainer: true)