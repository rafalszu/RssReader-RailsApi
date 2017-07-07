require 'rails_helper'

RSpec.describe Entry, type: :model do
  describe "Associations" do
    it { should belong_to(:feed) }
    it { should belong_to(:user) }
  end

  describe "Validations" do
    subject { described_class.new }
    let(:user) { User.new(email: 'random@addr.com') }
    let(:feed) { Feed.new(title: 'dummy', address: 'dummy', user: user) }

    it 'is valid with valid attributes' do
      subject.title = 'dummy'
      subject.permanent_url = 'dummy'
      subject.feed = feed
      subject.user = feed.user
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

    it 'is NOT valid without a user' do
      subject.user = nil
      expect(subject).to_not be_valid
    end
    
    describe 'censorable' do
      it 'removes <script> tag hidden in the title' do
        subject.title = '<div>hello<script>alert("jsbomb!")</script></div>'
        subject.valid?
        expect(subject.title).to eql('<div>hello</div>')
      end
      
      it 'does some additional html-encoding for encoded <script> tag hidden in the title' do
        subject.title = '<div>hello&lt;script&rt;alert("jsbomb!")&lt;/script&rt;</div>'
        subject.valid?
        expect(subject.title).to eql('<div>hello&lt;script&amp;rt;alert("jsbomb!")&lt;/script&amp;rt;</div>')
      end
      
      it 'does NOT change the title with whitelisted html tags' do
        subject.title = '<div><h3>a title</h3></div>'
        subject.valid?
        expect(subject.title).to eql('<div><h3>a title</h3></div>')
      end
      
      it 'does NOT change a plain text title' do
        subject.title = 'a title'
        subject.valid?
        expect(subject.title).to eql('a title')
      end
    end
  end

end
