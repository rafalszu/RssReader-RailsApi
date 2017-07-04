require 'uri_helper'
require 'html_helper'
require 'open-uri'
require 'base64'
require 'faraday'

module RssHelper
  module_function

  def latest_entries_from_content(content = '', uri = nil)
    return [] if content.blank?

    ready_content = content.strip
    return parse_feeds(content) if ready_content.downcase.starts_with?('<?xml', '<?rss', '<rss')

    if ready_content.downcase.starts_with?('<html', '<!doctype')
      feeds = HtmlHelper.extract_rss_feeds(content)
      feeds.each do |feed|
        url = uri.merge(feed).to_s unless uri.nil? || feed.starts_with?('http, https')
        url = feed if feed.starts_with?('http', 'https')
        return latest_entries_from_url(url)
      end
    end

    []
  end

  def latest_entries_from_url(url)
    uri = UriHelper.from_string(url)
    return [] if uri.nil?

    content = content_from_uri(uri)
    return [] if content.blank?

    latest_entries_from_content(content, uri)
  end

  def content_from_uri(uri)
    return '' if uri.nil?
    open_content_from_uri(uri)
  end

  def open_content_from_uri(uri)
    return '' if uri.nil?

    opts = { allow_redirections: :safe, ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE }
    open(uri, opts) { |f| @content = f.read if uri }
    # conv = Iconv.new('UTF-8', 'UTF-8')
    # @content = conv.iconv(@Content)
    @content
  end

  def parse_feeds(content)
    return [] if content.blank?

    feed = Feedjira::Feed.parse(content)
    feed.entries
  end

  private_class_method :content_from_uri, :open_content_from_uri, :parse_feeds
end
