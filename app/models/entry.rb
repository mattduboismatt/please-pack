class Entry < ApplicationRecord
  belongs_to :pool

  validates :pool, :name, :points, presence: true
end
