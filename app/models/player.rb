class Player < ApplicationRecord
  belongs_to :team
  has_many :scores

  validates :name, presence: true

  def total_scores
    scores.pluck(:point).sum
  end
end
