# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
u1 = User.create!(email: 'asdf@asdf', password: 'asdfasdf')
u2 = User.create!(email: 'sdf@asdf', password: 'asdfasdf')

Band.destroy_all
b1 = Band.create!(name: 'AC/DC')
b2 = Band.create!(name: 'Mad Lion')
b3 = Band.create!(name: 'Run DMC')

Album.destroy_all
a1 = Album.create!(band_id: b1.id, title: 'Highway to Hell', year: '1975')
a2 = Album.create!(band_id: b2.id, title: 'Real Ting', year: '1990')
a3 = Album.create!(band_id: b3.id, title: 'Run DMC', year: '1984')
a4 = Album.create!(band_id: b3.id, title: 'King of Rock', year: '1985')
a5 = Album.create!(band_id: b3.id, title: 'Raising Hell', year: '1986')

Track.destroy_all
Track.create!(album_id: a1.id, title: 'Highway to Hell', ord: 1, lyrics: 'ababbab')
Track.create!(album_id: a1.id, title: 'Girls Got Rythym', ord: 2)
Track.create!(album_id: a1.id, title: 'Walk All Over You', ord: 3)
Track.create!(album_id: a1.id, title: 'Touch Too Much', ord: 4)
