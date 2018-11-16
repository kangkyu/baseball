class PlayersController < ApplicationController

  def show
    @player = Player.includes(:team).find(params[:id])
  end

  def index
    @players = Player.includes(:scores).sort_by {|player| -player.total_scores}.first(10)
  end
end
