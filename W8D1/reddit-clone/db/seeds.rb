# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all

u1 = User.create!(username: 'Bob', password: 'password')
5.times do
  User.create!(username: Faker::Name.name, password: 'password')
end
user_ids = User.all.pluck(:id)

Sub.destroy_all
PostSub.destroy_all
5.times do
  s = Sub.create!(moderator_id: u1.id,
                  title: Faker::TvShows::RickAndMorty.location,
                  description: Faker::TvShows::RickAndMorty.quote)
  (rand 1...4).times do
    p = Post.create!(title: Faker::TvShows::TheFreshPrinceOfBelAir.character,
                 content: Faker::TvShows::TheFreshPrinceOfBelAir.quote,
                 sub_id: s.id,
                 author_id: user_ids.sample)
    PostSub.create!(post_id: p.id, sub_id: s.id)
  end
end

PostSub.create(post_id: Post.first.id, sub_id: Sub.first.id)
PostSub.create(post_id: Post.first.id, sub_id: Sub.second.id)
PostSub.create(post_id: Post.second.id, sub_id: Sub.first.id)

Comment.destroy_all
Post.all.each do |post|
  Comment.create!(content: Faker::TvShows::RickAndMorty.quote,
                  author_id: user_ids.sample,
                  post_id: post.id)
  c = Comment.create!(content: Faker::TvShows::RickAndMorty.quote,
                      author_id: user_ids.sample,
                      post_id: post.id)
  c2 = Comment.create!(content: Faker::TvShows::RickAndMorty.quote,
                       author_id: user_ids.sample,
                       post_id: post.id,
                       parent_comment_id: c.id)
  _c3 = Comment.create!(content: Faker::TvShows::RickAndMorty.quote,
                        author_id: user_ids.sample,
                        post_id: post.id,
                        parent_comment_id: c2.id)
end
