class Contestant < ApplicationRecord
  belongs_to :pool
  has_many :contestant_scores
  has_many :scores, through: :contestant_scores

  validates :pool, :first_name, presence: true

  def points
    scores.map(&:points).sum
  end
end
