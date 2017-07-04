require 'uri'

module UriHelper
  module_function
  
  def is_valid_url?(url = '')
    return false if url.blank? || url.split('.').length < 2
    
    url = "http://#{url}" unless url.start_with?('http', 'https')
    uri = URI.parse(url)
    
    uri.kind_of? URI::HTTP
  rescue URI::InvalidURIError
    false
  end
end
