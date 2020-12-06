poke = @pokemon

json.pokemon do
  json.set! poke.id do
    json.extract! poke, :id, :name, :attack, :defense, :poke_type
    json.image_url asset_path("pokemon_snaps/#{poke.image_url}")
  end
end

json.poke_moves do
  poke.poke_moves.each do |move|
    json.set! move.id do
      json.extract! move, :id, :pokemon_id, :move_id
    end
  end
end

json.moves do
  poke.moves.each do |move|
    json.set! move.id do
      json.extract! move, :id, :name
    end
  end
end

json.items do
  poke.items.each do |item|
    json.set! item.id do
      json.extract! item, :id, :pokemon_id, :name, :price, :happiness
      json.image_url asset_path("#{item.image_url}")
    end
  end
end
