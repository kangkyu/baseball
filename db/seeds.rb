# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

teams = Team.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
game = Game.create(field: 'A Stadium', away_team: teams.first, home_team: teams.second)
players = Player.create([{name: 'Jimmy Johnson', team: teams.first}, {name: 'Ed Kesson', team: teams.second}])
