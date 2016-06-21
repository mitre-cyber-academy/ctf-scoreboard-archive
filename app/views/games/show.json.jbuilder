json.array!(@game.players) do |json, player|
  json.name player.name
  json.tags player.tags

  # feed items
  json.feed player.feed_items.order('created_at') do |jayson, item|
    jayson.created_at item.created_at
    jayson.type item.type
    jayson.text item.text
    jayson.points item.point_value
    unless item.challenge.nil?
      jayson.text item.challenge.name
      jayson.points item.challenge.point_value
    end
  end
end
