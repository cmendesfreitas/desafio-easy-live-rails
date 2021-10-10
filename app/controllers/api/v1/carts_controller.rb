class Api::V1::CartsController < Api::ApplicationController
  before_action :set_cart, only: %i[show destroy]
  before_action :authenticate_api_v1_user!

  # GET /carts
  def index
    @carts = Cart.all

    render json: @carts
  end

  # POST /carts
  def create
    @cart = Cart.new(cart_params)

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
    @cart = Cart.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def cart_params
    params.require(:cart).permit(:user_id, :product_id)
  end
end
