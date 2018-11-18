json.array! @teams do |team|
  json.id team.id
  json.name team.name
  json.wins team.games.map {|g| team.win?(g) ? 1 : 0 }.sum
  json.loses team.games.map {|g| team.win?(g) ? 0 : 1 }.sum
end
