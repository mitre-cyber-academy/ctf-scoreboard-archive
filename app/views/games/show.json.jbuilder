json.array!(@game.players) do |json, player|
  json.name player.name
  json.tags player.tags
  
  # feed items
  json.feed player.feed_items.order("created_at") do |json, item|
    json.created_at item.created_at
    json.type item.type
    json.text item.text
    json.points item.point_value
    unless item.challenge.nil?
      json.text item.challenge.name
      json.points item.challenge.point_value
    end
  end
  
end