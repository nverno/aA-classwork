json.partial! @party, as: :party
json.guests @party.guests do |guest|
  json.name guest.name
  json.gifts guest.gifts, :title
end
