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
end
