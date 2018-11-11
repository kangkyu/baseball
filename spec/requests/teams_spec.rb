require 'rails_helper'

RSpec.describe "Teams", type: :request do
  describe "GET /teams" do
    it "returns HTTP status 200" do
      get teams_path
      expect(response).to have_http_status(200)
    end

    it "returns a list of teams" do
      teams = Team.create! [{ name: 'Mariners' }, { name: 'Brewers' }]

      get teams_path
      list_teams = JSON(response.body)
      expect(list_teams.size).to eq(2)
    end
  end

  describe "POST /teams" do
    context "with valid params" do
      it "creates a new team" do
        expect {
          post teams_path, params: { team: { name: 'Mariners' } }
        }.to change(Team, :count).by(1)
      end

      it "renders a JSON response with the new team" do
        post teams_path, params: { team: { name: 'Mariners' } }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new team" do
        post teams_path, params: { team: { name: '' } }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end
end
