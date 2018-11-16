json.array! @games do |game|
  json.id game.id
  json.field game.field
  json.score "#{game.away_team_score}:#{game.home_team_score}"
end
