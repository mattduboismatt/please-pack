class ContestantScore < ApplicationRecord
  belongs_to :contestant
  belongs_to :score

  validates :contestant, :score, presence: true
end
