require 'rails_helper'

RSpec.describe "Scores", type: :request do

  let(:game) { Game.create! field: 'Fenway Park', away_team: away_team, home_team: home_team }
  let(:away_team) { Team.create! name: 'Yankees' }
  let(:home_team) { Team.create! name: 'Red Sox' }
  let(:away_team_player_1) { Player.create(name: 'Aaron Judge', team: away_team) }
  let(:away_team_player_2) { Player.create(name: 'Giancarlo Stanton', team: away_team) }

  describe "POST /scores" do
    context "with valid params" do
      it "creates a new score" do
        expect {
          post scores_path, params: {
            score: { game_id: game.id, player_id: away_team_player_1.id, point: 3 }
          }
        }.to change(Score, :count).by(1)
      end

      it "renders a JSON response with the new score" do
        post scores_path, params: {
          score: { game_id: game.id, player_id: away_team_player_1.id, point: 3 }
        }
        expect(response).to have_http_status(201)
        expect(response.content_type).to eq('application/json')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the score" do
        post scores_path, params: {
          score: { game_id: '', player_id: '', point: 3 }
        }
        expect(response).to have_http_status(422)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "DELETE /scores/:id" do
    it "destroys the existing score" do
      score = Score.create! game_id: game.id, player_id: away_team_player_1.id, point: 3
      expect {
        delete "/scores/#{score.to_param}"
        expect(response).to have_http_status(204)
      }.to change(Score, :count).by(-1)
    end
  end
end
