class Game < ApplicationRecord
  belongs_to :home_team, class_name: 'Team', foreign_key: :home_team_id
  belongs_to :away_team, class_name: 'Team', foreign_key: :away_team_id
  has_many :scores

  def away_team_score
    scores.where(player: away_team.players).pluck(:point).sum
  end

  def home_team_score
    scores.where(player: home_team.players).pluck(:point).sum
  end
end
