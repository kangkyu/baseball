class PlayersController < ApplicationController

  def show
    @player = Player.includes(:team).find(params[:id])
  end

  def index
    @players = Player.all # TODO: get top scoring players
  end
end
