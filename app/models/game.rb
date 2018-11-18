class Game < ApplicationRecord
  belongs_to :home_team, class_name: 'Team'
  belongs_to :away_team, class_name: 'Team'
  has_many :scores

  def teams
    Team.where('id = ? OR id = ?', away_team_id, home_team_id)
  end

  def away_team_score
    team_score(away_team)
  end

  def home_team_score
    team_score(home_team)
  end

  def team_score(team)
    scores.where(player: team.players).pluck(:point).sum
  end
end
