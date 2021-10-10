class Product < ApplicationRecord
  belongs_to :store

  has_many :carts, dependent: :destroy
  has_many :users, through: :carts

  validates :product_id, :name, :price, :available_quantity, presence: true
  validates_uniqueness_of :product_id
  validates_inclusion_of :active, in: [true, false]

  before_save :set_prices

  private

  def set_prices
    self.price = price.to_f.round(2)
    self.original_price = original_price.to_f.round(2)
    self.installments_full_price = installments_full_price.to_f.round(2)
  end
end
