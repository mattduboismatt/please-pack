class Pool < ApplicationRecord
  has_many :contestants, dependent: :destroy
  has_many :entries, dependent: :destroy

  validates :title, presence: true
end
