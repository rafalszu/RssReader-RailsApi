require 'rails_helper'

RSpec.describe Entry, type: :model do
  describe "Associations" do
    it { should belong_to(:feed) }
  end
  
  describe "Validations" do
    subject { described_class.new }
    let(:feed) { Feed.new(title: 'dummy', address: 'dummy') }
    
    it 'is valid with valid attributes' do
      subject.title = 'dummy'
      subject.permanent_url = 'dummy'
      subject.feed = feed
      expect(subject).to be_valid
    end
    
    it 'is NOT valid without a permanent url' do
      subject.permanent_url = nil
      expect(subject).to_not be_valid
    end
    
    it 'is NOT valid without a title' do
      subject.title = nil
      expect(subject).to_not be_valid
    end
    it 'is NOT valid without a feed' do
      subject.feed = nil
      expect(subject).to_not be_valid
    end
  end
  
end
