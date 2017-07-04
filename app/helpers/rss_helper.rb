require 'uri_helper'
require 'digest/md5'
require 'nokogiri'
require 'open-uri'
require 'base64'
require 'faraday'

module RssHelper
  module_function
  
  def latest_entries_from_content(content = '')
    return [] if content.blank?

    
  end
  
  def latest_entries_from_url(url = '')
    content = get_content_from_url(url)
    return [] if content.blank?
    
    latest_entries_from_content(content)
  end

  def get_content_from_url(url = '')
    return '' if url.blank?
    return '' unless UriHelper.is_valid_url?(url)
    
    open_content_from_url(url)
  end
  
  def open_content_from_url (url = '')
    return '' if url.blank?
    return '' unless UriHelper.is_valid_url?(url)
    
    opts = { allow_redirections: :safe, ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE }
    open(addr, opts) { |f| @content = f.read if addr }
    # conv = Iconv.new('UTF-8', 'UTF-8')
    # @content = conv.iconv(@Content)
    @content
  end
  
  private_class_method :get_content_from_url, :open_content_from_url
  
end
