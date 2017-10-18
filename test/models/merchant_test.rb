require "test_helper"

describe Merchant do
  let(:merchant) { Merchant.new( username: 'testman',
        email: 'test@test.com',
        oauth_provider: 'github',
        oauth_uid: '1234567')
      }

  # it "must be valid" do
  #   value(merchant).must_be :valid?
  # end

  describe 'validations' do
    it 'can be created with valid data' do
      merchant.must_be :valid?
    end

    describe 'username' do
      it 'requires username' do
        merchant.username = nil
        merchant.email = 'test@test.com'
        merchant.oauth_provider = 'github'
        merchant.oauth_uid = '1234567'

        merchant.wont_be :valid?
      end
    end

  end

  describe 'relationships' do

  end
end
