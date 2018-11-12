class TeamsController < ApplicationController

  def index
    @teams = Team.all
    render formats: :json
  end

  def show
    @team = Team.find(params[:id])
    render formats: :json
  end

  def create
    @team = Team.new(team_params)
    if @team.save
      render :show, status: :created, formats: :json
    else
      render json: @team.errors, status: :unprocessable_entity
    end
  end

  def update
    @team = Team.find(params[:id])
    if @team.update(team_params)
      render :show, status: :ok, formats: :json
    else
      render json: @team.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @team = Team.find(params[:id])
    @team.destroy
    head :no_content
  end

  private

  def team_params
    params.require(:team).permit(:name)
  end
end
