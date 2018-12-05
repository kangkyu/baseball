require 'rails_helper'

RSpec.describe "Players", type: :request do

  describe "GET /players/:id" do
    let(:team) { Team.create! name: 'Mets' }
    let(:player) { team.players.create! name: 'Adrian Gonzalez' }

    it "returns HTTP status 200" do
      get "/players/#{player.to_param}"
      expect(response).to have_http_status(200)
    end

    it "returns a player" do
      get player_path(player.to_param)
      player_json = JSON response.body
      expect(player_json['name']).to eq('Adrian Gonzalez')
      expect(player_json['team']['name']).to eq('Mets')
    end
  end

  describe "GET /players" do
    let(:away_team) { Team.create! name: 'Yankees' }
    let(:home_team) { Team.create! name: 'Red Sox' }

    it "returns HTTP status 200" do
      get players_path
      expect(response).to have_http_status(200)
    end

    it "returns a list of players with their scores" do
      game_1 = Game.create! field: 'Fenway Park', away_team: away_team, home_team: home_team
      player_1 = Player.create! name: 'Mookie Betts', team: home_team
      player_2 = home_team.players.create(name: 'Chris Sale')
      Score.create! player: player_1, game: game_1, point: 2
      Score.create! player: player_2, game: game_1, point: 3

      get players_path
      list_players = JSON(response.body)
      expect(list_players[0]['name']).to eq('Chris Sale')
      expect(list_players[0]['scores']).to eq(3)
    end
  end

  describe "POST /players" do
    let(:team) { Team.create name: 'Dodgers' }

    context "with valid params" do
      it "creates a new player" do
        expect {
          post players_path, params: { player: { name: 'Clayton Kershaw', team_id: team.id } }
        }.to change(Player, :count).by(1)
      end

      it "renders a JSON response with the new player" do
        post players_path, params: { player: { name: 'Clayton Kershaw', team_id: team.id } }
        expect(response).to have_http_status(201)
        expect(response.content_type).to eq('application/json')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new player" do
        post players_path, params: { player: { name: '' } }
        expect(response).to have_http_status(422)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "PUT /players/:id" do
    let(:team) { Team.create name: 'Dodgers' }

    context "with valid params" do
      it "updates the player" do
        player = Player.create! name: 'Clayton Kershaw', team: team
        expect {
          put "/players/#{player.to_param}", params: { player: { name: 'Hyun-Jin Ryu' } }
          player.reload
          expect(player.name).to eq('Hyun-Jin Ryu')
        }.not_to change(Player, :count)
      end

      it "renders a JSON response with the updated player" do
        player = Player.create! name: 'Clayton Kershaw', team: team
        put "/players/#{player.to_param}", params: { player: { name: 'Hyun-Jin Ryu' } }
        expect(response).to have_http_status(200)
        expect(response.content_type).to eq('application/json')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the the player" do
        player = Player.create! name: 'Clayton Kershaw', team: team
        put player_path(player), params: { player: { name: '' } }
        expect(response).to have_http_status(422)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "DELETE /players/:id" do
    let(:team) { Team.create name: 'Dodgers' }

    it "destroys the existing player" do
      player = Player.create! name: 'Clayton Kershaw', team: team
      expect {
        delete "/players/#{player.to_param}"
        expect(response).to have_http_status(204)
      }.to change(Player, :count).by(-1)
    end
  end
end
