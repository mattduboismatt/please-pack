class Pick < ApplicationRecord
  belongs_to :entry
  belongs_to :contestant

  validates :entry, :contestant, presence: true

  scope :excluding_contestants, ->(contestant_ids) { where.not(contestant_id: contestant_ids) }
end
