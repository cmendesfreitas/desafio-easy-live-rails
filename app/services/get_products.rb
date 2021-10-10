class GetProducts
  include HTTParty

  def initialize(url)
    @url_mercado_livre = 'https://www.mercadolivre.com.br/perfil/'
    @type = if url.include? @url_mercado_livre
              'mercadolivre'
            else
              'vtex'
            end
    @url = url
  end

  def self.call(params)
    new(params).get_products
  end

  def self.test(params)
    new(params).test_valid_api
  end

  def test_valid_api
    begin
      product_array = get_from_url(0)
    rescue HTTParty::Error
      return false
    rescue StandardError
      return false
    end

    return false if product_array.success? != true

    return !product_array['seller'].blank? if @type == 'mercadolivre'
  end

  def get_products
    return 'Url invalida' if @url.blank?

    @store_id = Store.find_by_url(@url)&.id

    return 'Loja invalida' if @store_id.blank?

    quantity_aux = 0
    keep = true

    while keep != false
      products_aux = get_from_url(quantity_aux)

      if products_aux.success? != true
        return
      else
        keep = products_aux.success?

        if @type == 'mercadolivre'
          wrapper_mercado_livre(products_aux)
        else
          wrapper_vtex(products_aux)
        end
      end

      quantity_aux += 50
    end
  end

  private

  def get_from_url(quantity)
    self.class.get(set_url(quantity))
  end

  def set_url(quantity)
    if @type == 'mercadolivre'
      url_aux = @url.remove(@url_mercado_livre)
      "https://api.mercadolibre.com/sites/MLB/search?nickname=#{url_aux}&offset=#{quantity}"
    else
      url_aux = if @url.ends_with?('/')
                  @url
                else
                  "#{@url}/"
                end
      "#{url_aux}api/catalog_system/pub/products/search?_from=#{quantity}&_to=#{quantity + 49}"
    end
  end

  def wrapper_mercado_livre(product_array)
    product_array['results'].each do |product|
      insert_product(
        product_id: product['id'],
        name: product['title'],
        description: nil,
        price: product['price'],
        original_price: product['original_price'],
        number_of_installments: product['installments']['quantity'],
        installments_full_price: product['installments']['amount'] * product['installments']['quantity'],
        image_url: product['thumbnail'],
        available_quantity: product['available_quantity'],
        store_id: @store_id
      )
    end
  end

  def wrapper_vtex(product_array)
    product_array.each do |product|
      next unless product['items'][0]['sellers'][0]['commertialOffer']['IsAvailable'] == true

      max_number_of_installments = 0
      total_value_installments = 0
      product['items'][0]['sellers'][0]['commertialOffer']['Installments'].each do |installments|
        if installments['PaymentSystemGroupName'] == 'creditCardPaymentGroup' && installments['NumberOfInstallments'] > max_number_of_installments
          max_number_of_installments = installments['NumberOfInstallments']
          total_value_installments = installments['TotalValuePlusInterestRate']
        end
      end

      insert_product(
        product_id: product['productId'],
        name: product['productName'],
        description: product['description'],
        price: product['items'][0]['sellers'][0]['commertialOffer']['Price'],
        original_price: product['items'][0]['sellers'][0]['commertialOffer']['ListPrice'],
        number_of_installments: max_number_of_installments,
        installments_full_price: total_value_installments,
        image_url: product['items'][0]['images'][0]['imageUrl'],
        available_quantity: product['items'][0]['sellers'][0]['commertialOffer']['AvailableQuantity'],
        store_id: @store_id
      )
    end
  end

  def insert_product(product_id:, name:, description:, price:, original_price:,
                     number_of_installments:, installments_full_price:, image_url:,
                     available_quantity:, store_id:)
    hash_data = Product.new(
      product_id: product_id,
      name: name,
      description: description,
      price: price,
      original_price: original_price,
      number_of_installments: number_of_installments,
      installments_full_price: installments_full_price,
      image_url: image_url,
      available_quantity: available_quantity,
      store_id: store_id
    )

    if hash_data.save
      puts "O produto #{hash_data[:name]} foi adicionado com sucesso"
    else
      puts productAux.errors.full_messages
    end
  end
end
