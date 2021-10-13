class Api::V1::ProductsController < Api::ApplicationController
  include Api::V1::ProductsControllerDoc

  before_action :set_products, only: [:index]
  before_action :set_product, only: [:show]
  before_action :authenticate_api_v1_user!

  def index
    render json: { products: @products, last_page: @products.last_page? }
  end

  def show
    @cart_item = current_api_v1_user&.products.exists?(id: @product.id)
    @store = @product.store

    render json: { product: @product, on_cart: @cart_item, store: @store }
  end

  private

  def set_products
    q_aux = params[:search_query]
    @q = if q_aux && q_aux != ''
           q_aux
         else
           '*'
         end

    @page = params[:page].to_s
    @order = params[:order].to_s
    @per_page = 15

    @products = if @order == 'name desc'
                  Product.search(@q, fields: %i[name description],
                                     where: { _and: [{ _not: { price: 0 } }, { _not: { available_quantity: 0 } }, { active: true }] },
                                     order: { name: 'desc' },
                                     page: @page,
                                     per_page: @per_page)
                elsif @order == 'name asc'
                  Product.search(@q, fields: %i[name description],
                                     where: { _and: [{ _not: { price: 0 } }, { _not: { available_quantity: 0 } }, { active: true }] },
                                     order: { name: 'asc' },
                                     page: @page,
                                     per_page: @per_page)
                elsif @order == 'price desc'
                  Product.search(@q, fields: %i[name description],
                                     where: { _and: [{ _not: { price: 0 } }, { _not: { available_quantity: 0 } }, { active: true }] },
                                     order: { price: 'desc' },
                                     page: @page,
                                     per_page: @per_page)
                else
                  Product.search(@q, fields: %i[name description],
                                     where: { _and: [{ _not: { price: 0 } }, { _not: { available_quantity: 0 } }, { active: true }] },
                                     order: { price: 'asc' },
                                     page: @page,
                                     per_page: @per_page)
                end
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
