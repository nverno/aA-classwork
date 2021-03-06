# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
ActiveRecord::Base.transaction do
  User.destroy_all
  user1 = User.create!(username: 'Thor')
  user2 = User.create!(username: 'Zeus')
  user3 = User.create!(username: 'Dido')

  # Artwork.destroy_all
  art1 = Artwork.create!(artist_id: user1.id, title: 'The Scream',
                         image_url: 'http://buyartposter.blogspot.com/', favorite: true)
  art2 = Artwork.create!(artist_id: user1.id, title: 'Flowers',
                         image_url: 'http://buyartposter.blogspot.com/')
  art3 = Artwork.create!(artist_id: user2.id, title: 'sky',
                         image_url: 'https://upload.wikimedia.org/wikipedia/commons/8/85/Sky-3.jpg',
                         favorite: true)
  art4 = Artwork.create!(artist_id: user1.id, title: 'sky',
                         image_url: 'https://upload.wikimedia.org/wikipedia/commons/8/85/Sky-3.jpg',
                         favorite: true)

  # ArtworkShare.destroy_all
  artshare1 = ArtworkShare.create!(artwork_id: art1.id, viewer_id: user2.id)
  artshare2 = ArtworkShare.create!(artwork_id: art3.id, viewer_id: user1.id, favorite: true)
  artshare3 = ArtworkShare.create!(artwork_id: art3.id, viewer_id: user3.id, favorite: true)

  c1 = Comment.create!(user_id: user1.id, artwork_id: art1.id, body: 'U suck!')
  c2 = Comment.create!(user_id: user2.id, artwork_id: art1.id, body: 'Yea, this is baaaad XD')
  c3 = Comment.create!(user_id: user3.id, artwork_id: art1.id, body: 'I love it')

  # Likes
  l1 = Like.create!(user_id: user1.id, likeable_id: art1.id, likeable_type: 'Artwork')
  l2 = Like.create!(user_id: user1.id, likeable_id: art2.id, likeable_type: 'Artwork')
  l3 = Like.create!(user_id: user1.id, likeable_id: c2.id, likeable_type: 'Comment')
  l4 = Like.create!(user_id: user2.id, likeable_id: art1.id, likeable_type: 'Artwork')
  l5 = Like.create!(user_id: user2.id, likeable_id: c1.id, likeable_type: 'Comment')

  # Collections
  coll1 = Collection.create!(user_id: user1.id, name: "Thor's shizzle")
  coll2 = Collection.create!(user_id: user2.id, name: "Zeus' shizzle")

  ac1 = ArtworkCollection.create!(collection_id: coll1.id, artwork_id: art1.id)
  ac2 = ArtworkCollection.create!(collection_id: coll1.id, artwork_id: art2.id)
  ac3 = ArtworkCollection.create!(collection_id: coll1.id, artwork_id: art3.id)

  ac4 = ArtworkCollection.create!(collection_id: coll2.id, artwork_id: art3.id)
  ac5 = ArtworkCollection.create!(collection_id: coll2.id, artwork_id: art4.id)
end
