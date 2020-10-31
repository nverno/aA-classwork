# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Cat.destroy_all

cat1 = Cat.create!(birth_date: '2015/01/20', color: 'red', name: 'kitty',
                   sex: 'F', description: 'scary cat')
cat2 = Cat.create!(birth_date: Date.new(2010, 1, 2), color: 'orange',
                   name: 'thor', sex: 'M',
                   description: 'scary angry cat with a hammer')
cat3 = Cat.create!(birth_date: Date.new(2011, 2, 11), color: 'brown',
                   name: 'dino', sex: 'F',
                   description: 'prehistoric cat with scales')
cat4 = Cat.create!(birth_date: Date.new(2015, 1, 1),
                   color: 'yellow', name: 'zeus',
                   sex: 'M', description: 'hairy cat')
cat5 = Cat.create!(birth_date: Date.new(2020, 1, 1),
                   color: 'orange', name: 'spiderman',
                   sex: 'M', description: 'creepy cat')
cat6 = Cat.create!(birth_date: Date.new(1999, 1, 1),
                   color: 'red', name: 'nancy',
                   sex: 'F', description: 'proper cat')
cat7 = Cat.create!(birth_date: Date.new(1901, 1, 1),
                   color: 'brown', name: 'anansi',
                   sex: 'F', description: 'trickster cat')


# Rentals
r1 = CatRentalRequest.create!(cat_id: cat1.id,
                              start_date: Date.new(2020, 10, 1),
                              end_date: Date.new(2020, 11, 1),
                              status: 'APPROVED')
r2 = CatRentalRequest.create!(cat_id: cat2.id,
                              start_date: Date.new(2020, 10, 25),
                              end_date: Date.new(2020, 11, 15),
                              status: 'PENDING')
r3 = CatRentalRequest.create!(cat_id: cat4.id,
                              start_date: Date.new(2020, 10, 25),
                              end_date: Date.new(2020, 11, 15),
                              status: 'DENIED')
