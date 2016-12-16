class Contestant < ApplicationRecord
  belongs_to :pool
  has_many :contestant_scores, dependent: :destroy
  has_many :scores, through: :contestant_scores
  has_many :picks, dependent: :destroy

  validates :pool, :first_name, presence: true

  scope :active, -> { where(eliminated: false) }
  scope :eliminated, -> { where(eliminated: true) }

  def points
    scores.map(&:points).sum
  end
end
