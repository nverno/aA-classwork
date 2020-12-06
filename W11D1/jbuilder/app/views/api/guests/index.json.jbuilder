gs = @guests.where('age BETWEEN 40 and 50')
json.array! gs do |guest|
  json.name guest.name
  json.age guest.age
  json.favorite_color guest.favorite_color
end
