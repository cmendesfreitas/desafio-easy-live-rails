class Api::V1::CartsController < Api::ApplicationController
  include Api::V1::CartsControllerDoc

  before_action :set_cart, only: %i[show destroy]
  before_action :authenticate_api_v1_user!

  # GET /carts
  def index
    @carts = current_api_v1_user.products

    render json: @carts
  end

  # POST /carts
  def create
    @cart = current_api_v1_user.carts.new(cart_params)

    if @cart.save
      render json: @cart, status: :created, location => api_v1_carts_url
    else
      render json: @cart.errors, status: :unprocessable_entity
    end
  end

  # DELETE /carts/1
  def destroy
    @cart.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_cart
    @cart = current_api_v1_user&.products&.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def cart_params
    params.permit(:product_id)
  end
end
