class ScoresController < ApplicationController
  def create
    @score = Score.new(score_params)
    if @score.save
      head :created
    else
      render json: @score.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @score = Score.find(params[:id])
    @score.destroy
    head :no_content
  end

  private

  def score_params
    params.require(:score).permit(:player_id, :game_id, :point)
  end
end
