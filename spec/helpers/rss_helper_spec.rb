require 'rails_helper'

def load_content_from_fixture(filename)
  File.read(File.join(Rails.root, 'spec', 'fixtures', 'rss', filename))
end

RSpec.describe RssHelper, type: :helper do
  describe 'object' do
    it 'responds to .latest_entries_from_url' do
      expect(helper).to respond_to(:latest_entries_from_url)
    end

    it 'responds to .latest_entries_from_content' do
      expect(helper).to respond_to(:latest_entries_from_content)
    end

    it '.get_content_from_url is private' do
      expect(helper).to_not respond_to(:get_content_from_url)
    end
  end

  context 'working with empty content' do
    it '.latest_entries_from_url returns empty array for nil' do
      expect(helper.latest_entries_from_url(nil)).to match_array([])
    end

    it '.latest_entries_from_url returns empty array for empty string' do
      expect(helper.latest_entries_from_url('')).to match_array([])
    end

    it '.latest_entries_from_content returns empty array for nil' do
      expect(helper.latest_entries_from_content(nil)).to match_array([])
    end

    it '.latest_entries_from_content returns empty array for empty string' do
      expect(helper.latest_entries_from_content('')).to match_array([])
    end
  end

  context 'working with malformed content' do
    it '.latest_entries_from_url returns empty array for simple text' do
      expect(helper.latest_entries_from_url('a simple text')).to match_array([])
    end

    it '.latest_entries_from_content returns emplty array for simple text' do
      expect(helper.latest_entries_from_content('a simple text')).to match_array([])
    end
  end

  context 'working with RSS content' do
    context 'company feed' do
      before(:each) do
        @content = load_content_from_fixture('bs.rss.xml')
      end
      it '.latest_entries_from_content returns 10 articles from company feed' do
        expect(helper.latest_entries_from_content(@content).length).to eq(10)
      end

      it 'all entries have titles' do
        articles = helper.latest_entries_from_content(@content)
        expect(articles.any? { |a| a.title.blank? }).to be false
      end

      it 'all entries have permanent urls' do
        articles = helper.latest_entries_from_content(@content)
        expect(articles.any? { |a| a.permanent_url.blank? }).to be false
      end
    end

    context 'wired feed' do
      before(:each) do
        @content = load_content_from_fixture('wired.rss.xml')
      end

      it '.latest_entries_from_content returns 30 articles from wired feed' do
        expect(helper.latest_entries_from_content(@contentcontent).length).to eq(30)
      end

      it 'all entries have titles' do
        articles = helper.latest_entries_from_content(@content)
        expect(articles.any? { |a| a.title.blank? }).to be false
      end

      it 'all entries have permanent urls' do
        articles = helper.latest_entries_from_content(@content)
        expect(articles.any? { |a| a.permanent_url.blank? }).to be false
      end
    end
  end
end
