class Api::V1::ProductsController < Api::ApplicationController
  include Api::V1::ProductsControllerDoc

  before_action :set_product, only: [:show]
  before_action :authenticate_api_v1_user!

  def index
    products = Product.where('price > ? && available_quantity > ? && active = ?', 0, 0, true)
    @q = params[:search_query]
    @page = params[:page].to_s
    @order = params[:order].to_s
    @per_page = 15

    @products = if @q && @q != ''
                  if @order == 'name desc'
                    products.search(@q, order: { name: 'desc' }, page: @page, per_page: @per_page)
                  elsif @order == 'name asc'
                    products.search(@q, order: { name: 'asc' }, page: @page, per_page: @per_page)
                  elsif @order == 'price desc'
                    products.search(@q, order: { price: 'desc' }, page: @page, per_page: @per_page)
                  else
                    products.search(@q, order: { name: 'asc' }, page: @page, per_page: @per_page)
                  end
                elsif @order == 'name desc'
                  products.search('*', order: { name: 'desc' }, page: @page, per_page: @per_page)
                elsif @order == 'name asc'
                  products.search('*', order: { name: 'asc' }, page: @page, per_page: @per_page)
                elsif @order == 'price desc'
                  products.search('*', order: { price: 'desc' }, page: @page.to_i, per_page: @per_page)
                else
                  products.search('*', fields: %i[name description], order: { price: 'asc' }, page: @page,
                                       per_page: @per_page)
                end

    render json: { products: @products, last_page: @products.last_page? }
  end

  def show
    @cart_item = current_api_v1_user&.products.exists?(id: @product.id)
    @store = @product.store

    render json: { product: @product, on_cart: @cart_item, store: @store }
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end
end
