class Entry < ApplicationRecord
  belongs_to :pool
  has_many :picks
  has_many :contestants, through: :picks

  validates :pool, :name, :points, presence: true
end
