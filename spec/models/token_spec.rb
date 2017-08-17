require 'rails_helper'

RSpec.describe Token, type: :model do
  describe 'validations' do
    it 'should validate precense' do
      token = build :token, token: nil
      expect(token).not_to be_valid
      expect(token.errors.messages[:token]).to include("can't be blank")
    end

    it 'should validate uniqueness' do
      token1 = create :token
      token2 = build :token, token: token1.token
      expect(token2).not_to be_valid
      expect(token2.errors.messages[:token]).to include("has already been taken")
    end

    it 'should have valid factory' do
      access_token = build :token
      expect(access_token).to be_valid
    end

    it 'should have uniq token after initialization' do
      access_token = Token.new
      expect(access_token.token).to be_present
    end
  end
end
