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

  describe '#update_from_feed' do

    before :each do
      rss_entry1 = Feedjira::Parser::RSSEntry.new(title: 'entry1', summary: 'entry1_summary', url: 'http://fake/addr/entry1', 
                                                  entry_id: '595672cd3ff99d6b3a1d1c4d')
      rss_entry2 = Feedjira::Parser::RSSEntry.new(title: 'entry2', summary: 'entry2_summary', url: 'http://fake/addr/entry2', 
                                                  entry_id: '59554f98bc22c16d4e75d494')

      allow(Entry).to receive(:find_or_create_by!).and_return(true)
      allow(subject).to receive(:latest_entries_from_feed).and_return([rss_entry1, rss_entry2])
    end

    it 'returns nil when feed is new' do
      expect(subject.update_from_feed).to be_nil
    end

    it 'returns nil when feed.address is empty' do
      subject.id = 5
      expect(subject.update_from_feed).to be_nil
    end

    it 'returns true when nonexisting entries passed' do
      subject.id = 5
      subject.user = User.new(id: 1)
      subject.address = 'http://fake.address'
      expect(subject.update_from_feed).to be_truthy
    end
  end
end
