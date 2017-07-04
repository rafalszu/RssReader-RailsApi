require 'rails_helper'

RSpec.describe UriHelper, type: :helper do
  describe 'object' do
    it 'responds to is_valid_url?' do
      expect(helper).to respond_to(:is_valid_url?)
    end
  end
  
  describe 'Validations' do
    it 'recognizes a NOT valid url when passing an empty string' do
      expect(helper.is_valid_url?('')).to be false
    end
    
    it 'recognizes a NOT valid url when passign a nil object' do
      expect(helper.is_valid_url?(nil)).to be false
    end
    
    it 'recognizes a NOT valid url when passing spaced string' do
      expect(helper.is_valid_url?('dummy string')).to be false
    end
    
    it 'recognizes a NOT valid url when passing html-escaped string' do
      expect(helper.is_valid_url?('dummy%20string')).to be false
    end
    
    it 'recognizes a NOT valid url when passing javascript embed' do
      expect(helper.is_valid_url?('javascript:console.log("www.onet.pl")')).to be false
      expect(helper.is_valid_url?('javascript:alert("www.onet.pl")')).to be false
    end
    
    it 'recognizes a NOT valid url when passign html-escaped string with protocol' do
      expect(helper.is_valid_url?('http://dummy%20string')).to be false
    end
    
    it 'recognizes a valid url when passing fqdn without protocol' do
      expect(helper.is_valid_url?('www.google.com')).to be true
    end
    
    it 'recognizes a valid url when passing just the domain name' do
      expect(helper.is_valid_url?('google.com')).to be true
    end
    
    it 'recognizes a valid url when passing an fqdn with protocol' do
      expect(helper.is_valid_url?('http://google.com')).to be true
      expect(helper.is_valid_url?('https://google.com')).to be true
    end
    
    it 'recognizes a valid url when passign fqdn with port' do
      expect(helper.is_valid_url?('www.google.com:8081')).to be true
    end
    
    it 'recognizes a valid url when passing a domain name with port and protocol' do
      expect(helper.is_valid_url?('http://google.com:8081')).to be true
      expect(helper.is_valid_url?('https://google.com:8081')).to be true
    end
    
    it 'recognizes a valid url when passing an fqdn with port and protocol' do
      expect(helper.is_valid_url?('http://www.google.com:8081')).to be true
      expect(helper.is_valid_url?('https://www.google.com:8081')).to be true
    end
    
    it 'recognizes a valid url when passing a subpath to domain name with port' do
      expect(helper.is_valid_url?('www.google.com:8081/some/nested/folder/rss')).to be true
    end
    
    it 'recognizes a valid url when passing a subpath to fqdn with port and protocol' do
      expect(helper.is_valid_url?('http://www.google.com:8081/some/nested/folder/rss')).to be true
      expect(helper.is_valid_url?('https://www.google.com:8081/some/nested/folder/rss')).to be true
    end
    
  end
end
