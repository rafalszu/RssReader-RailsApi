require 'uri_helper'
module RssHelper
  module_function
  
  def latest_entries_from_content(content = '')
    return [] if content.blank?

    
  end
  
  def latest_entries_from_url(url = '')
    byebug
    content = get_content_from_url(url)
    return [] if content.blank?
    
    latest_entries_from_content(content)
  end

  def get_content_from_url(url = '')
    return '' if url.blank?
    return '' unless UriHelper.is_valid_url?(url)
    

  end
  private_class_method :get_content_from_url
  
end
