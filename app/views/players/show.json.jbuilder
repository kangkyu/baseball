json.extract! @player, :id, :name
json.team do
  json.name @player.team.name
end
