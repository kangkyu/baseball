require 'rails_helper'

RSpec.describe "Games", type: :request do

  describe "GET /games/:id" do
    let(:game) { Game.create! field: 'Fenway Park' }

    it "returns HTTP status 200" do
      get "/games/#{game.to_param}", as: :json
      expect(response).to have_http_status(200)
    end
  end
end
