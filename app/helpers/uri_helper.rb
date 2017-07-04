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

  def merge_from_strings(url, source_url)
    source_uri = from_string(source_url)
    uri = source_uri.merge(url) unless source_uri.nil?
    uri = from_string(url) if source_uri.nil?

    uri
  end
end
