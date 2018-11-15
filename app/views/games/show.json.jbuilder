json.extract! @game, :id, :field
json.title "#{@game.away_team.name} vs #{@game.home_team.name}"
json.teams do
  json.away_team @game.away_team, :id, :name
  json.home_team @game.home_team, :id, :name
end
