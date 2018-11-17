class Score < ApplicationRecord
  belongs_to :game
  belongs_to :player

  validates :point, presence: true
end
