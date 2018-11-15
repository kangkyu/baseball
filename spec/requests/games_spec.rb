require 'rails_helper'

RSpec.describe "Games", type: :request do

  describe "GET /games/:id" do
    let(:game) { Game.create! field: 'Fenway Park', away_team: away_team, home_team: home_team }
    let(:away_team) { Team.create! name: 'Yankees' }
    let(:home_team) { Team.create! name: 'Red Sox' }

    it "returns HTTP status 200" do
      get "/games/#{game.to_param}", as: :json
      expect(response).to have_http_status(200)
    end

    it "returns a game" do
      get game_path(game.to_param), as: :json
      game_json = JSON response.body
      expect(game_json).to be_a Hash
      expect(game_json['field']).to eq('Fenway Park')
    end

    it "returns a game and its teams" do
      get game_path(game.to_param), as: :json
      game_json = JSON response.body
      expect(game_json['title']).to eq('Yankees vs Red Sox')
      expect(game_json['teams']).to be_a Hash
      expect(game_json['teams']['home_team']['name']).to eq('Red Sox')
      expect(game_json['teams']['away_team']['name']).to eq('Yankees')
    end
  end
end
