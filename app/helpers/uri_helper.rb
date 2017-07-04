require 'uri'

module UriHelper
  module_function

  def valid_url?(url = '')
    return false if url.blank? || url.split('.').length < 2

    url = "http://#{url}" unless url.start_with?('http', 'https')
    uri = URI.parse(url)

    uri.kind_of? URI::HTTP
  rescue URI::InvalidURIError
    false
  end

  def from_string(url = '')
    return nil unless valid_url?(url)

    url = "http://#{url}" unless url.start_with?('http', 'https')
    URI.parse(url)
  end
end
