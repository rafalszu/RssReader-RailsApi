require 'rails_helper'

RSpec.describe Feed, type: :model do
  subject { described_class.new }
  let(:user) { User.new(email: 'random@addr.com') }
  
  describe 'Associations' do
    it { should have_many(:entries) }
    it { should belong_to(:user) }
  end
  
  describe "Validations" do
    it 'is valid with valid attributes' do
      subject.address = 'dummy'
      subject.title = 'dummy'
      subject.user = user
      
      expect(subject).to be_valid
    end
    
    it 'is NOT valid without a title' do
      subject.title = nil
      expect(subject).to_not be_valid
    end
    
    it 'is NOT valid without an address' do
      subject.address = nil
      expect(subject).to_not be_valid
    end
    
    it 'is NOT valid without a user' do
      subject.user = nil
      expect(subject).to_not be_valid
    end
  end
end
