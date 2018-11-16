class Player < ApplicationRecord
  belongs_to :team
  has_many :scores

  def total_scores
    scores.pluck(:point).sum
  end
end
