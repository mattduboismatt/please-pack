class Entry < ApplicationRecord
  belongs_to :pool
  has_many :picks, dependent: :destroy
  has_many :contestants, through: :picks

  validates :pool, :name, presence: true

  def points
    contestants.map(&:points).sum
  end
end
