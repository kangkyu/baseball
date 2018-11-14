require 'rails_helper'

RSpec.describe "Teams", type: :request do
  describe "GET /teams" do
    it "returns HTTP status 200" do
      get teams_path, as: :json
      expect(response).to have_http_status(200)
    end

    it "returns a list of teams" do
      teams = Team.create! [{ name: 'Mariners' }, { name: 'Brewers' }]

      get teams_path, as: :json
      list_teams = JSON(response.body)
      expect(list_teams.size).to eq(2)
    end
  end

  describe "GET /teams/:id" do
    it "returns HTTP status 200" do
      team = Team.create! name: 'Mariners'

      get "/teams/#{team.to_param}", as: :json
      expect(response).to have_http_status(200)
    end

    it "returns a team" do
      team = Team.create! name: 'Mariners'

      get team_path(team.to_param), as: :json
      team_json = JSON response.body
      expect(team_json['name']).to eq('Mariners')
    end

    it "returns its players too" do
      team = Team.create! name: 'Mariners'
      team.players.push Player.create(name: 'James Paxton'), Player.create(name: 'Mitch Haniger')

      get team_path(team.to_param), as: :json
      team_json = JSON response.body
      expect(team_json['players']).to be_an Array
      expect(team_json['players'][0]['name']).to eq('James Paxton')
    end
  end

  describe "POST /teams" do
    context "with valid params" do
      it "creates a new team" do
        expect {
          post teams_path, params: { team: { name: 'Mariners' } }, as: :json
        }.to change(Team, :count).by(1)
      end

      it "renders a JSON response with the new team" do
        post teams_path, params: { team: { name: 'Mariners' } }, as: :json
        expect(response).to have_http_status(201)
        expect(response.content_type).to eq('application/json')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new team" do
        post teams_path, params: { team: { name: '' } }, as: :json
        expect(response).to have_http_status(422)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "PUT /teams/:id" do
    context "with valid params" do
      it "updates the team" do
        team = Team.create! name: 'Mariners'
        expect {
          put "/teams/#{team.to_param}", params: { team: { name: 'Dodgers' } }, as: :json
          team.reload
          expect(team.name).to eq('Dodgers')
        }.not_to change(Team, :count)
      end

      it "renders a JSON response with the updated team" do
        team = Team.create! name: 'Mariners'
        put "/teams/#{team.to_param}", params: { team: { name: 'Dodgers' } }, as: :json
        expect(response).to have_http_status(200)
        expect(response.content_type).to eq('application/json')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the the team" do
        team = Team.create! name: 'Mariners'
        put team_path(team.to_param), params: { team: { name: '' } }
        expect(response).to have_http_status(422)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "DELETE /teams/:id" do
    it "destroys the existing team" do
      team = Team.create! name: 'Mariners'
      expect {
        delete "/teams/#{team.to_param}"
        expect(response).to have_http_status(204)
      }.to change(Team, :count).by(-1)
    end
  end
end
