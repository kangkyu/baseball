class AddTeamIdsToGames < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :home_team_id, :integer
    add_column :games, :away_team_id, :integer
  end
end
