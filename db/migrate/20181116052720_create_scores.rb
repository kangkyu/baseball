class CreateScores < ActiveRecord::Migration[5.2]
  def change
    create_table :scores do |t|
      t.integer :point
      t.integer :player_id
      t.integer :game_id
    end
  end
end
