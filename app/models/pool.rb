class Pool < ApplicationRecord
  has_many :contestants
  has_many :entries

  validates :title, presence: true
end
