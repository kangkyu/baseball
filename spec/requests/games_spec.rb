require 'rails_helper'

RSpec.describe "Games", type: :request do

  describe "GET /games/:id" do
    let(:game) { Game.create! field: 'Fenway Park', away_team: away_team, home_team: home_team }
    let(:away_team) { Team.create! name: 'Yankees' }
    let(:home_team) { Team.create! name: 'Red Sox' }

    it "returns HTTP status 200" do
      get "/games/#{game.to_param}"
      expect(response).to have_http_status(200)
    end

    it "returns a game" do
      get game_path(game.to_param)
      game_json = JSON response.body
      expect(game_json).to be_a Hash
      expect(game_json['field']).to eq('Fenway Park')
    end

    it "returns a game and its teams" do
      get game_path(game.to_param)
      game_json = JSON response.body
      expect(game_json['title']).to eq('Yankees vs Red Sox')
      expect(game_json['teams']).to be_a Hash
      expect(game_json['teams']['home_team']['name']).to eq('Red Sox')
      expect(game_json['teams']['away_team']['name']).to eq('Yankees')
    end
  end

  describe "GET /games" do
    let(:away_team_1) { Team.create! name: 'Yankees' }
    let(:away_team_2) { Team.create! name: 'Brewers' }
    let(:home_team) { Team.create! name: 'Red Sox' }

    it "returns HTTP status 200" do
      get games_path
      expect(response).to have_http_status(200)
    end

    it "returns a list of games" do
      Game.create! field: 'Fenway Park', away_team: away_team_1, home_team: home_team
      Game.create! field: 'Fenway Park', away_team: away_team_2, home_team: home_team

      get games_path
      list_games = JSON(response.body)
      expect(list_games.size).to eq(2)
    end

    it "returns a list of games with their scores" do
      game_1 = Game.create! field: 'Fenway Park', away_team: away_team_1, home_team: home_team
      game_2 = Game.create! field: 'Fenway Park', away_team: away_team_2, home_team: home_team
      home_team.players.push Player.create(name: 'Mookie Betts'), Player.create(name: 'Chris Sale')
      Score.create! player: game_1.home_team.players.take, game: game_1, point: 3

      get games_path
      list_games = JSON(response.body)

      expect(list_games[0]['field']).to eq('Fenway Park')
      expect(list_games[0]['score']).to eq('0:3')
    end
  end

  describe "POST /games" do
    let(:away_team) { Team.create! name: 'Angels' }
    let(:home_team) { Team.create! name: 'Mariners' }

    context "with valid params" do
      it "creates a new game" do
        expect {
          post games_path, params: { game: { field: 'Safeco Field',
            away_team_id: away_team.id, home_team_id: home_team.id } }
        }.to change(Game, :count).by(1)
      end

      it "renders a JSON response with the new game" do
        post games_path, params: { game: { field: 'Safeco Field',
            away_team_id: away_team.id, home_team_id: home_team.id } }
        expect(response).to have_http_status(201)
        expect(response.content_type).to eq('application/json')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new game" do
        post games_path, params: { game: { field: '',
            away_team_id: away_team.id, home_team_id: home_team.id } }
        expect(response).to have_http_status(422)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "PUT /games/:id" do
    let(:away_team) { Team.create! name: 'Angels' }
    let(:home_team_1) { Team.create! name: 'Mariners' }
    let(:home_team_2) { Team.create! name: 'Dodgers' }

    context "with valid params" do
      it "updates the game" do
        game = Game.create! field: 'Safeco Field', away_team_id: away_team.id, home_team_id: home_team_1.id
        expect {
          put "/games/#{game.to_param}", params: { game: { field: 'Dodger Stadium',
            away_team_id: away_team.id, home_team_id: home_team_2.id } }
          game.reload
          expect(game.field).to eq('Dodger Stadium')
        }.not_to change(Game, :count)
      end

      it "renders a JSON response with the updated game" do
        game = Game.create! field: 'Safeco Field', away_team_id: away_team.id, home_team_id: home_team_1.id
        put "/games/#{game.to_param}", params: { game: { home_team_id: home_team_2.id } }
        expect(response).to have_http_status(200)
        expect(response.content_type).to eq('application/json')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the the game" do
        game = Game.create! field: 'Safeco Field', away_team_id: away_team.id, home_team_id: home_team_1.id
        put game_path(game.to_param), params: { game: { field: '' } }
        expect(response).to have_http_status(422)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "DELETE /games/:id" do
    let(:away_team) { Team.create! name: 'Angels' }
    let(:home_team) { Team.create! name: 'Mariners' }

    it "destroys the existing game" do
      game = Game.create! field: 'Safeco Field', away_team_id: away_team.id, home_team_id: home_team.id
      expect {
        delete "/games/#{game.to_param}"
        expect(response).to have_http_status(204)
      }.to change(Game, :count).by(-1)
    end
  end
end
