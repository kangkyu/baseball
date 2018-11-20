class GamesController < ApplicationController
  def show
    @game = Game.find(params[:id])
  end

  def index
    @games = Game.all
  end

  def create
    @game = Game.new(game_params)
    if @game.save
      render :show, status: :created
    else
      render json: @game.errors, status: :unprocessable_entity
    end
  end

  def update
    @game = Game.find(params[:id])
    if @game.update(game_params)
      render :show, status: :ok
    else
      render json: @game.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @game = Game.find(params[:id])
    @game.destroy
    head :no_content
  end

  private

  def game_params
    params.require(:game).permit(:field, :away_team_id, :home_team_id)
  end
end
