class PlayersController < ApplicationController

  def show
    @player = Player.includes(:team).find(params[:id])
  end
end
