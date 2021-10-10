require 'rails_helper'

RSpec.describe Cart, type: :model do
  context 'all fields' do
    it 'are valid' do
      cart = build(:cart)
      expect(cart).to be_valid
    end
  end

  context 'validate user' do
    it 'is invalid' do
      cart = build(:cart, user_id: 0)
      expect(cart).to_not be_valid
    end
  end

  context 'validate product' do
    it 'is invalid' do
      cart = build(:cart, product_id: 0)
      expect(cart).to_not be_valid
    end
  end
end
