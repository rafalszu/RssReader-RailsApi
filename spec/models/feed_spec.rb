require 'rails_helper'

RSpec.describe Feed, type: :model do
  subject { described_class.new }
  
  describe 'Associations' do
    it { should have_many(:entries) }
    it { should belong_to(:user) }
  end
  
  describe "Validations" do
    it 'is valid with valid attributes' do
      subject.address = 'dummy'
      subject.title = 'dummy'
      
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
  end
end
