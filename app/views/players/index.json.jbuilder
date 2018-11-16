json.array! @players do |player|
  json.id player.id
  json.name player.name
  json.scores player.total_scores
end
