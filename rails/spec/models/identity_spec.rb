require 'rails_helper'

RSpec.describe Identity, :type => :model do

  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:uid) }
  it { should validate_presence_of(:provider) }

  it { should validate_uniqueness_of(:uid).scoped_to(:provider) }

  describe '.find_from_hash' do
    it 'should find identity from omniauth hash' do
      Identity.create(user_id: 34, uid: '12345', provider: 'turing')
      hash = { 'provider' => 'turing', 'uid' => '12345', 'credentials' => {'token' => '12345'}}
      identity = Identity.find_from_hash(hash)
      expect(identity.user_id).to eq(34)
    end
  end

  describe '.create_from_hash' do
    it 'should create identity from omniauth hash' do
      hash = { 'provider' => 'turing', 'uid' => '12345', 'info' => {'first_name' => 'Jon'}, 'credentials' => {'token' => '12345'}}
      expect(User.count).to eq(0)
      identity = Identity.create_from_hash(hash)
      expect(User.count).to eq(1)
      expect(User.last.id).to eq(identity.user_id)
    end

    it 'saves additional data based on provider' do
      hash = { 'provider' => 'soundcloud', 'uid' => '12345', 'info' => {'first_name' => 'Jon'}, 'credentials' => {'token' => '12345'}, 'extra' => {'raw_info' => { 'id' => '12345'}}}
      identity = Identity.create_from_hash(hash)
      expect(identity.user.soundcloud_user_id).to eq '12345'
    end
  end
end
