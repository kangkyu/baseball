class PlayersController < ApplicationController
  def show
    @player = Player.find(params[:id])
    render formats: :json
  end
end
