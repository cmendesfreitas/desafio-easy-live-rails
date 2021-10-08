require 'rails_helper'

RSpec.describe User, type: :model do
  context 'all fields' do
    it 'are present' do
      user = build(:user)
      expect(user).to be_valid
    end
  end

  context 'validate name' do
    it 'is not present' do
      user = build(:user, name: '')
      expect(user).to_not be_valid
    end
  end

  context 'validate email' do
    it 'is not present' do
      user = build(:user, email: '')
      expect(user).to_not be_valid
    end

    it 'has format invalid' do
      user = build(:user, email: 'aa%11.com')
      expect(user).to_not be_valid
    end

    it 'is unique' do
      user1 = create(:user)
      user2 = build(:user, email: user1.email)
      expect(user1).to be_valid
      expect(user2).to_not be_valid

      user2.valid?
      expect(user2.errors[:email]).to include('has already been taken')
    end
  end
end
