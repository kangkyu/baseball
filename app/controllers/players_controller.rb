class PlayersController < ApplicationController
  def show
    @player = Player.includes(:team).find(params[:id])
  end

  def index
    @players = Player.includes(:scores).sort_by {|player| -player.total_scores}.first(10)
  end

  def create
    @player = Player.new(player_params)
    if @player.save
      render :show, status: :created
    else
      render json: @player.errors, status: :unprocessable_entity
    end
  end

  def update
    @player = Player.find(params[:id])
    if @player.update(player_params)
      render :show, status: :ok
    else
      render json: @player.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @player = Player.find(params[:id])
    @player.destroy
    head :no_content
  end

  private

  def player_params
    params.require(:player).permit(:name, :team_id)
  end
end
