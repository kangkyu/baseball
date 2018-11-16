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
    it "returns HTTP status 200" do
      get players_path, as: :json
      expect(response).to have_http_status(200)
    end
  end
end
