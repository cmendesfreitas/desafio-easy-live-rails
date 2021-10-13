require 'rails_helper'

RSpec.describe Admin, type: :model do
  context 'all fields' do
    it 'are present' do
      admin = build(:admin)
      expect(admin).to be_valid
    end
  end

  context 'validate name' do
    it 'is not present' do
      admin = build(:admin, name: '')
      expect(admin).to_not be_valid
    end
  end

  context 'validate email' do
    it 'is not present' do
      admin = build(:admin, email: '')
      expect(admin).to_not be_valid
    end

    it 'has format invalid' do
      admin = build(:admin, email: 'aa%11.com')
      expect(admin).to_not be_valid
    end

    it 'is unique' do
      admin1 = create(:admin)
      admin2 = build(:admin, email: admin1.email)
      expect(admin1).to be_valid
      expect(admin2).to_not be_valid
    end
  end
end
