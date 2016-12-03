class Contestant < ApplicationRecord
  belongs_to :pool

  validates :pool, :first_name, presence: true
end
