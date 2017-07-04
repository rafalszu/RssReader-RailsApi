require 'nokogiri'
require 'base64'
require 'open-uri'
require 'base64'
require 'faraday'

module HtmlHelper
  module_function

  def extract_rss_feeds(content)
    return nil if content.blank?
    doc = Nokogiri::HTML(content)

    x_pathhandler = Class.new do
      def atomxml(node_set)
        node_set.find_all do |node|
          node['type'] =~ /atom\+xml$/i
        end
      end

      def rssxml(node_set)
        node_set.find_all do |node|
          node['type'] =~ /rss\+xml$/i
        end
      end
    end

    xfeeds = doc.css('link:atomxml()', x_pathhandler.new)
    xfeeds = doc.css('link:rssxml()', x_pathhandler.new) if xfeeds.empty?

    xfeeds.map { |e| e['href'] }
  end
  
  def image_as_base64(addr)
    return nil if addr.blank?
    file = get_file(addr)
    'data:' + get_image_content_type(addr) + ';base64,' + Base64.strict_encode64(file.to_a.join)
  end
  
  def get_file(addr)
    return nil if addr.blank?
    open(addr, allow_redirections: :safe)
  end
  
  def get_image_content_type(path)
    ext = File.extname(path)
    return 'image/png' if ext.eql?('.png')
    return 'image/jpg' if ext.eql?('.jpg')

    ''
  end
  
  def sanitize_html(content)
    return nil if content.blank?
    
    doc = Nokogiri::HTML(content)
    content_dup = content.dup
    doc.css('img').each do |img|
      content_dup.gsub! img['src'], image_as_base64(img['src'])
    end

    content_dup
  end
end
