class Pool < ApplicationRecord
  has_many :contestants
  validates :title, presence: true
end
