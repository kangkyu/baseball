require 'rails_helper'

RSpec.describe "Players", type: :request do

  describe "GET /players/:id" do
    let(:team) { Team.create! name: 'Mets' }
    let(:player) { team.players.create! name: 'Adrian Gonzalez' }

    it "returns HTTP status 200" do
      get "/players/#{player.to_param}", as: :json
      expect(response).to have_http_status(200)
    end

    it "returns a player" do
      get player_path(player.to_param), as: :json
      player_json = JSON response.body
      expect(player_json['name']).to eq('Adrian Gonzalez')
      expect(player_json['team']['name']).to eq('Mets')
    end
  end

  describe "GET /players" do
    let(:away_team) { Team.create! name: 'Yankees' }
    let(:home_team) { Team.create! name: 'Red Sox' }

    it "returns HTTP status 200" do
      get players_path, as: :json
      expect(response).to have_http_status(200)
    end

    it "returns a list of players with their scores" do
      game_1 = Game.create! field: 'Fenway Park', away_team: away_team, home_team: home_team
      player_1 = Player.create! name: 'Mookie Betts', team: home_team
      player_2 = home_team.players.create(name: 'Chris Sale')
      Score.create! player: player_1, game: game_1, point: 2
      Score.create! player: player_2, game: game_1, point: 3

      get players_path, as: :json
      list_players = JSON(response.body)
      expect(list_players[0]['name']).to eq('Chris Sale')
      expect(list_players[0]['scores']).to eq(3)
    end
  end
end
