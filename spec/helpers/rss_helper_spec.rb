require 'rails_helper'

def load_content_from_fixture(filename)
  File.read(File.join(Rails.root, 'spec', 'fixtures', 'rss', filename))
end

RSpec.describe RssHelper, type: :helper do
  describe 'object' do
    it 'responds to .latest_entries_from_url' do
      expect(RssHelper).to respond_to(:latest_entries_from_url)
    end

    it 'responds to .latest_entries_from_content' do
      expect(RssHelper).to respond_to(:latest_entries_from_content)
    end

    it '.get_content_from_url is private' do
      expect(RssHelper).to_not respond_to(:get_content_from_url)
    end
    
    it '.open_content_from_url is private' do
      expect(RssHelper).to_not respond_to(:open_content_from_url)
    end
    
    it '.parse_feeds is private' do
      expect(RssHelper).to_not respond_to(:parse_feeds)
    end
  end

  context 'working with empty content' do
    it '.latest_entries_from_url returns empty array for nil' do
      expect(RssHelper.latest_entries_from_url(nil)).to match_array([])
    end

    it '.latest_entries_from_url returns empty array for empty string' do
      expect(RssHelper.latest_entries_from_url('')).to match_array([])
    end

    it '.latest_entries_from_content returns empty array for nil' do
      expect(RssHelper.latest_entries_from_content(nil)).to match_array([])
    end

    it '.latest_entries_from_content returns empty array for empty string' do
      expect(RssHelper.latest_entries_from_content('')).to match_array([])
    end
  end

  context 'working with malformed content' do
    it '.latest_entries_from_url returns empty array for simple text' do
      expect(RssHelper.latest_entries_from_url('a simple text')).to match_array([])
    end

    it '.latest_entries_from_content returns empty array for simple text' do
      expect(RssHelper.latest_entries_from_content('a simple text')).to match_array([])
    end
  end

  context 'working with RSS content' do
    context 'company feed' do
      before(:each) do
        @content = load_content_from_fixture('bs.rss.xml')
      end
      it '.latest_entries_from_content returns 10 articles from company feed' do
        expect(RssHelper.latest_entries_from_content(@content).length).to eq(10)
      end

      it 'all entries have titles' do
        articles = RssHelper.latest_entries_from_content(@content)
        expect(articles.any? { |a| a.title.blank? }).to be false
      end

      it 'all entries have permanent urls' do
        articles = RssHelper.latest_entries_from_content(@content)
        expect(articles.any? { |a| a.url.blank? }).to be false
      end

      it '.latest_entries_from_content returns 10 articles from company feed when content is prefixed with whitespaces' do
        articles = RssHelper.latest_entries_from_content("     \n  #{@content}")
        expect(articles.length).to eq(10)
      end
    end

    context 'wired feed' do
      before(:each) do
        @content = load_content_from_fixture('wired.rss.xml')
      end

      it '.latest_entries_from_content returns 30 articles from wired feed' do
        expect(RssHelper.latest_entries_from_content(@content).length).to eq(30)
      end

      it 'all entries have titles' do
        articles = RssHelper.latest_entries_from_content(@content)
        expect(articles.any? { |a| a.title.blank? }).to be false
      end

      it 'all entries have permanent urls' do
        articles = RssHelper.latest_entries_from_content(@content)
        expect(articles.any? { |a| a.url.blank? }).to be false
      end

      it '.latest_entries_from_content returns 30 articles from company feed when content is prefixed with whitespaces' do
        articles = RssHelper.latest_entries_from_content("  \t   \n  #{@content}")
        expect(articles.length).to eq(30)
      end
    end

    describe 'relative path merging' do
      before :all do
        @relative_rss = '<html><head><link rel="stylesheet" href="foo1.css"><link rel="alternate" type="application/rss+xml" href="relative/fakeaddr"/></head><body></body></html>'
        @absolute_rss = '<html><head><link rel="stylesheet" href="foo1.css"><link rel="alternate" type="application/rss+xml" href="http://some.address/absolute/fakeaddr"/></head><body></body></html>'
      end
      before :each do
        allow(RssHelper).to receive(:open_content_from_uri) do |uri|
          if uri.to_s.eql?('http://some.address/absolute/fakeaddr')
            '<?xml version="1.0" encoding="utf-8"?><rss xmlns:atom="http://www.w3.org/2005/Atom" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:media="http://search.yahoo.com/mrss/" version="2.0"><channel><title>sample rss</title><description>The latest news</description><link>https://www.some.address</link><atom:link href="https://www.some.address/feed/" rel="self" type="application/rss+xml"/><copyright>2017</copyright><language>en</language><lastBuildDate>Mon, 03 Jul 2017 20:06:46 +0000</lastBuildDate><item><title>sample absolute title</title><description>desc</description><link>https://www.some.address/blabla</link><guid isPermaLink="false">5952a43138978176dacc5761</guid><pubDate>Mon, 03 Jul 2017 16:00:00 +0000</pubDate><media:content/><category>cat1</category><category>cat2</category><media:keywords>keyword1, keyword2</media:keywords><dc:creator>the admin</dc:creator></item></channel></rss>'
          elsif uri.to_s.eql?('http://some.address/relative/fakeaddr')
            '<?xml version="1.0" encoding="utf-8"?><rss xmlns:atom="http://www.w3.org/2005/Atom" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:media="http://search.yahoo.com/mrss/" version="2.0"><channel><title>sample rss</title><description>The latest news</description><link>https://www.some.address</link><atom:link href="https://www.some.address/feed/" rel="self" type="application/rss+xml"/><copyright>2017</copyright><language>en</language><lastBuildDate>Mon, 03 Jul 2017 20:06:46 +0000</lastBuildDate><item><title>sample relative title</title><description>desc</description><link>https://www.some.address/blabla</link><guid isPermaLink="false">5952a43138978176dacc5761</guid><pubDate>Mon, 03 Jul 2017 16:00:00 +0000</pubDate><media:content/><category>cat1</category><category>cat2</category><media:keywords>keyword1, keyword2</media:keywords><dc:creator>the admin</dc:creator></item></channel></rss>'
          end
        end
      end

      it '.latest_entries_from_content get 1 article from absolute redirection' do
        expect(RssHelper.latest_entries_from_content(@absolute_rss).length).to eq(1)
      end

      it 'latest_entries_from_content get 1 article from absolute redirection with title "sample absolute title"' do
        articles = RssHelper.latest_entries_from_content(@absolute_rss)
        expect(articles.first.title).to eql('sample absolute title')
      end

      it '.latest_entries_from_content get 1 article from relative redirection' do
        articles = RssHelper.latest_entries_from_content(@relative_rss, URI('http://some.address'))
        expect(articles.length).to eq(1)
      end

      it '.latest_entries_from_content get 1 article from relative redirection with title "sample relative title"' do
        articles = RssHelper.latest_entries_from_content(@relative_rss, URI('http://some.address'))
        expect(articles.first.title).to eql('sample relative title')
      end
    end
  end
end
