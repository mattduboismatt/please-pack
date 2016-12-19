class Score < ApplicationRecord
  module MECHANISMS
    QUICKFIRE = "quickfire".freeze
    WEEKLY_WINNER = "weekly winner".freeze
    ADVANCEMENT = "advancement".freeze
    ELIMINATION = "elimination".freeze

    def self.all
      [QUICKFIRE, WEEKLY_WINNER, ADVANCEMENT]
    end

    def self.top_chef
      [QUICKFIRE, WEEKLY_WINNER, ELIMINATION]
    end
  end

  has_many :contestant_scores
  has_many :contestants, through: :contestant_scores

  validates :points, :mechanism, presence: true
  validates :mechanism, inclusion: { in: MECHANISMS.all }
  validates :points, numericality: { greater_than: 0 }
end
