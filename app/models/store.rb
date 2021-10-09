class Store < ApplicationRecord
  has_many :products, dependent: :destroy

  validates :name, :url, presence: true
  validates_uniqueness_of :url
  validates_inclusion_of :active, in: [true, false]
end
