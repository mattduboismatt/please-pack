class Pick < ApplicationRecord
  belongs_to :entry
  belongs_to :contestant

  validates :entry, :contestant, presence: true
end
