# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all
Todo.destroy_all
Tag.destroy_all
u1 = User.create!(username: 'asdf', password: 'asdfasdf')
u2 = User.create!(username: 'guest', password: 'password')

tags = 5.times.collect do
  Tag.create!(name: Faker::Hacker.adjective)
end

10.times do
  todo = Todo.create!(
    title: Faker::TvShows::RickAndMorty.character,
    body: Faker::TvShows::RickAndMorty.quote,
    done: [true, false].sample,
    user_id: [u1.id, u2.id].sample
  )

  3.times do
    Step.create!(
      todo_id: todo.id,
      title: Faker::Games::StreetFighter.character,
      body: Faker::Games::StreetFighter.quote,
      done: [true, false].sample
    )
  end

  tags.sample(2).each do |tag|
    Tagging.create!(tag_id: tag.id, todo_id: todo.id)
  end
end
