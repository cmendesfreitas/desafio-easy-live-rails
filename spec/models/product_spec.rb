require 'rails_helper'

RSpec.describe Product, type: :model do
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

      product2.valid?
      expect(product2.errors[:product_id]).to include('has already been taken')
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
end
