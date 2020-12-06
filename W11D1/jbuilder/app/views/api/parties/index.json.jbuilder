json.array! @parties do |party|
  json.partial! party, as: :party
  json.guests do
    json.array! party.guests
  end
end
