class Store < ApplicationRecord
  has_many :products, dependent: :destroy

  validates :name, :url, presence: true
  validates_uniqueness_of :url
  validates_inclusion_of :active, in: [true, false]

  validate :validate_url_api

  after_save :insert_products

  private

  def insert_products
    GetProducts.call(url)
  end

  def validate_url_api
    response = GetProducts.test(url)

    if response == false
      errors.add(:url,
                 ' da loja inserida não existe como API ou não foi implementada sua coleta de dados pela plataforma. A loja só pode ser adicionada com uma url de API válida. Cheque o endereço URL e o padrão da plataforma e tente novamente!')
    end
  end
end
