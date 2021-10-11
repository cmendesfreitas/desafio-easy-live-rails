class CartSerializer < ActiveModel::Serializer
  attributes :id
  belongs_to :user, serializer: UserSerializer
  belongs_to :product, serializer: ProductSerializer
end
