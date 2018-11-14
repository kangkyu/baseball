class PlayersController < ApplicationController

  def show
    @player = Player.includes(:team).find(params[:id])
    render formats: :json
  end
end
