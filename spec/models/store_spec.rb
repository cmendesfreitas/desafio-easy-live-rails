require 'rails_helper'

RSpec.describe Store, type: :model do
  context 'validate name' do
    it 'is not present' do
      store = build(:store, name: '')
      expect(store).to_not be_valid
    end
  end

  context 'validate url' do
    it 'is not present' do
      store = build(:store, url: '')
      expect(store).to_not be_valid
    end

    it 'is unique' do
      store1 = create(:store)
      store2 = build(:store, url: store1.url)
      expect(store1).to be_valid
      expect(store2).to_not be_valid

      store2.valid?
      expect(store2.errors[:url]).to include('has already been taken')
    end
  end

  context 'validate active' do
    it 'is not true or false' do
      store = build(:store, active: nil)
      expect(store).to_not be_valid
    end
  end
end
