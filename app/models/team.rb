class Team < ApplicationRecord

  validates :name, presence: true
  has_many :players

  def games
    Game.where("away_team_id = ? OR home_team_id = ?", self.id, self.id)
  end

  def the_other_team(game)
    game.teams.where.not(id: self.id).first
  end

  def win?(game)
    game.team_score(self) > game.team_score(the_other_team(game))
  end

  def win_count
    games.count {|g| win?(g)}
  end
end
