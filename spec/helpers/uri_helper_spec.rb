require 'rails_helper'

RSpec.describe UriHelper, type: :helper do
  describe 'object' do
    it 'responds to valid_url?' do
      expect(UriHelper).to respond_to(:valid_url?)
    end
  end

  describe 'Validations' do
    it 'recognizes a NOT valid url when passing an empty string' do
      expect(UriHelper.valid_url?('')).to be false
    end

    it 'recognizes a NOT valid url when passign a nil object' do
      expect(UriHelper.valid_url?(nil)).to be false
    end

    it 'recognizes a NOT valid url when passing spaced string' do
      expect(UriHelper.valid_url?('dummy string')).to be false
    end

    it 'recognizes a NOT valid url when passing html-escaped string' do
      expect(UriHelper.valid_url?('dummy%20string')).to be false
    end

    it 'recognizes a NOT valid url when passing javascript embed' do
      expect(UriHelper.valid_url?('javascript:console.log("www.onet.pl")')).to be false
      expect(UriHelper.valid_url?('javascript:alert("www.onet.pl")')).to be false
    end

    it 'recognizes a NOT valid url when passign html-escaped string with protocol' do
      expect(UriHelper.valid_url?('http://dummy%20string')).to be false
    end

    it 'recognizes a valid url when passing fqdn without protocol' do
      expect(UriHelper.valid_url?('www.google.com')).to be true
    end

    it 'recognizes a valid url when passing just the domain name' do
      expect(UriHelper.valid_url?('google.com')).to be true
    end

    it 'recognizes a valid url when passing an fqdn with protocol' do
      expect(UriHelper.valid_url?('http://google.com')).to be true
      expect(UriHelper.valid_url?('https://google.com')).to be true
    end

    it 'recognizes a valid url when passign fqdn with port' do
      expect(UriHelper.valid_url?('www.google.com:8081')).to be true
    end

    it 'recognizes a valid url when passing a domain name with port and protocol' do
      expect(UriHelper.valid_url?('http://google.com:8081')).to be true
      expect(UriHelper.valid_url?('https://google.com:8081')).to be true
    end

    it 'recognizes a valid url when passing an fqdn with port and protocol' do
      expect(UriHelper.valid_url?('http://www.google.com:8081')).to be true
      expect(UriHelper.valid_url?('https://www.google.com:8081')).to be true
    end

    it 'recognizes a valid url when passing a subpath to domain name with port' do
      expect(UriHelper.valid_url?('www.google.com:8081/some/nested/folder/rss')).to be true
    end

    it 'recognizes a valid url when passing a subpath to fqdn with port and protocol' do
      expect(UriHelper.valid_url?('http://www.google.com:8081/some/nested/folder/rss')).to be true
      expect(UriHelper.valid_url?('https://www.google.com:8081/some/nested/folder/rss')).to be true
    end

    it '.from_string returns nil if given an invalid url string' do
      expect(UriHelper.from_string('just a string')).to be nil
    end

    it '.from_string returns URI if given a valid url string' do
      expect(UriHelper.from_string('www.google.com')).to be_kind_of(URI)
    end

    it '.from_string returns URI with scheme if given a valid url string' do
      expect(UriHelper.from_string('www.google.com').scheme).to eql('http')
    end

    it '.from_string returns URI without changing the scheme if passed' do
      expect(UriHelper.from_string('https://google.com').scheme).to eql('https')
    end

  end
end
