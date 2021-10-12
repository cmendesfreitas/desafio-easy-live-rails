class ProductSerializer < ActiveModel::Serializer
  attributes :id, :product_id, :name, :price, :original_price, :number_of_installments,
             :installments_full_price, :image_url, :available_quantity,
             :description
  belongs_to :store, serializer: StoreSerializer
end
