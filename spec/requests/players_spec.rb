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
      player = JSON response.body
      expect(player['name']).to eq('Adrian Gonzalez')
      expect(player['teamId']).to eq(team.to_param)
    end
  end
end
