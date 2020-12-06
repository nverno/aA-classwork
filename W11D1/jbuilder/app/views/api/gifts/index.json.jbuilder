json.array! @gifts do |gift|
  json.partial! gift, as: :gift
end
