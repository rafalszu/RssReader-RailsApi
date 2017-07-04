require 'rails_helper'

RSpec.describe HtmlHelper, type: :helper do
  before :all do
    @imgpath = File.join(Rails.root, 'spec', 'fixtures', 'img', '1x1.png')
    @html = '<html><head></head><body><p>test string</p></body></html>'
    @html_with_img = "<html><head></head><body><img src=\"#{@imgpath}\"/></body></html>"
    @encoded_img = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAIAAACQd1PeAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAB3RJTUUH4AgbFSo4MHw/UAAAAB1pVFh0Q29tbWVudAAAAAAAQ3JlYXRlZCB3aXRoIEdJTVBkLmUHAAAADElEQVQI12P4//8/AAX+Av7czFnnAAAAAElFTkSuQmCC'
    @result_html_with_img = "<html><head></head><body><img src=\"#{@encoded_img}\"/></body></html>"
  end
  
  describe 'image content type' do
    it '.get_image_content_type returns image/png for png file' do
      expect(HtmlHelper.get_image_content_type('some.file.png')).to eql('image/png')
    end
    
    it '.get_image_content_type returns image/jpg for jpg file' do
      expect(HtmlHelper.get_image_content_type('some.file.jpg')).to eql('image/jpg')
    end
    
    it 'get_image_content_type returns empty for other filetypes' do
      expect(HtmlHelper.get_image_content_type('some-file.pdf')).to eql('')
      expect(HtmlHelper.get_image_content_type('some-file.docx')).to eql('')
      expect(HtmlHelper.get_image_content_type('some%20file.abc')).to eql('')
      expect(HtmlHelper.get_image_content_type('some file.xyz')).to eql('')
    end
  end
  
  describe '.image_as_base64' do
    it 'should return nil for a nil addr' do
      expect(HtmlHelper.image_as_base64(nil)).to eql(nil)
    end

    it 'should return nil for a empty string' do
      expect(HtmlHelper.image_as_base64('')).to eql(nil)
    end

    it 'should encode 1x1.png to given format' do
      expect(HtmlHelper.image_as_base64(@imgpath)).to eql(@encoded_img)
    end
  end
  
  describe '.extract_rss_feeds' do
    it 'should return nil for nil content' do
      expect(HtmlHelper.extract_rss_feeds(nil)).to eql(nil)
    end

    it 'should return nil for empty string' do
      expect(HtmlHelper.extract_rss_feeds('')).to eql(nil)
    end

    let(:atomfakehtml) { '<html><head><link rel="stylesheet" href="foo1.css"><link rel="alternate" type="application/atom+xml" href="fakeaddr"/></head><body></body></html>' }
    let(:rssfakehtml) { '<html><head><link rel="stylesheet" href="foo1.css"><link rel="alternate" type="application/rss+xml" href="fakeaddr"/></head><body></body></html>' }

    it 'should return ATOM feed addresses out of given pseudo html' do
      expect(HtmlHelper.extract_rss_feeds(atomfakehtml)).to contain_exactly('fakeaddr')
    end

    it 'should return ATOM feed addresses out of given pseudo capital html' do
      expect(HtmlHelper.extract_rss_feeds(atomfakehtml.upcase)).to contain_exactly(/fakeaddr/i)
    end

    it 'should return RSS feed addresses out of given pseudo html' do
      expect(HtmlHelper.extract_rss_feeds(rssfakehtml)).to contain_exactly('fakeaddr')
    end

    it 'should return RSS feed addresses out of given pseudo capital html' do
      expect(HtmlHelper.extract_rss_feeds(rssfakehtml.upcase)).to contain_exactly(/fakeaddr/i)
    end
  end
    
  describe '.get_file' do
    it 'should return nil when passing nil' do
      expect(HtmlHelper.get_file(nil)).to eql(nil)
    end

    it 'should return empty string when passing empty string' do
      expect(HtmlHelper.get_file('')).to eql(nil)
    end

    it 'should read 1x1.png file' do
      expect(HtmlHelper.get_file(@imgpath)).to be_a(Object)
    end
  end
  
  describe '.sanitize_html' do
    it 'should return empty string when passing empty string' do
      expect(HtmlHelper.sanitize_html('')).to eql(nil)
    end

    it 'should return nil when passing nil' do
      expect(HtmlHelper.sanitize_html(nil)).to eql(nil)
    end

    it 'should return processed output' do
      expect(HtmlHelper.sanitize_html(@html)).to eql(@html)
    end

    it 'should return encoded string as base 64' do
      expect(HtmlHelper.sanitize_html(@html_with_img)).to eql(@result_html_with_img)
    end
  end
end
