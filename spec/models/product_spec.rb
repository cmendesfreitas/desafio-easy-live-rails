require 'rails_helper'

RSpec.describe Product, type: :model, search: true do
  context 'validate product_id' do
    it 'is not present' do
      product = build(:product, product_id: '')
      expect(product).to_not be_valid
    end

    it 'is unique' do
      product1 = create(:product)
      product2 = build(:product, product_id: product1.product_id)
      expect(product1).to be_valid
      expect(product2).to_not be_valid
    end
  end

  context 'validate name' do
    it 'is not present' do
      product = build(:product, name: '')
      expect(product).to_not be_valid
    end
  end

  context 'validate price' do
    it 'is not present' do
      product = build(:product, price: '')
      expect(product).to_not be_valid
    end
  end

  context 'validate available_quantity' do
    it 'is not present' do
      product = build(:product, available_quantity: '')
      expect(product).to_not be_valid
    end
  end

  context 'validate active' do
    it 'is not true or false' do
      product = build(:product, active: nil)
      expect(product).to_not be_valid
    end
  end

  context 'validate search' do
    it 'searches' do
      store = create(:store)
      product = Product.create!(attributes_for(:product, store_id: store.id))
      Product.search_index.refresh
      assert_equal [product.name], Product.search(product.name).map(&:name)
    end
  end
end
