class Api::V1::ProductsController < Api::ApplicationController
  include Api::V1::ProductsControllerDoc

  before_action :set_product, only: [:show]
  before_action :authenticate_api_v1_user!

  def index
    @products = Product.where('price > ? && available_quantity > ? && active = ?', 0, 0, true)

    render json: @products
  end

  def show
    render json: @product
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end
end
