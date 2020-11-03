# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# Users
User.destroy_all
u1 = User.create!(username: 'oranghutan', password: 'asdfasdf')
u2 = User.create!(username: 'bobo', password: 'asdfasdf')

Cat.destroy_all

cat1 = Cat.create!(birth_date: '2015/01/20', color: 'red', name: 'kitty',
                   sex: 'F', description: 'scary cat', user_id: u1.id)
cat2 = Cat.create!(birth_date: Date.new(2010, 1, 2), color: 'orange',
                   name: 'thor', sex: 'M', user_id: u1.id,
                   description: 'scary angry cat with a hammer')
cat3 = Cat.create!(birth_date: Date.new(2011, 2, 11), color: 'brown',
                   name: 'dino', sex: 'F', user_id: u2.id,
                   description: 'prehistoric cat with scales')
cat4 = Cat.create!(birth_date: Date.new(2015, 1, 1),
                   color: 'yellow', name: 'zeus', user_id: u1.id,
                   sex: 'M', description: 'hairy cat')
cat5 = Cat.create!(birth_date: Date.new(2020, 1, 1),
                   color: 'orange', name: 'spiderman', user_id: u2.id,
                   sex: 'M', description: 'creepy cat')
cat6 = Cat.create!(birth_date: Date.new(1999, 1, 1),
                   color: 'red', name: 'nancy', user_id: u1.id,
                   sex: 'F', description: 'proper cat')
cat7 = Cat.create!(birth_date: Date.new(1901, 1, 1),
                   color: 'brown', name: 'anansi', user_id: u2.id,
                   sex: 'F', description: 'trickster cat')


# Rentals
r1 = CatRentalRequest.create!(cat_id: cat1.id,
                              start_date: Date.new(2020, 10, 1),
                              end_date: Date.new(2020, 11, 1),
                              status: 'APPROVED', user_id: u2.id)
r2 = CatRentalRequest.create!(cat_id: cat2.id,
                              start_date: Date.new(2020, 10, 25),
                              end_date: Date.new(2020, 11, 15),
                              status: 'PENDING', user_id: u2.id)
r3 = CatRentalRequest.create!(cat_id: cat4.id,
                              start_date: Date.new(2020, 10, 25),
                              end_date: Date.new(2020, 11, 15),
                              status: 'DENIED', user_id: u2.id)
