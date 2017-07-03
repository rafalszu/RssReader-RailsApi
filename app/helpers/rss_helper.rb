module RssHelper
  def latest_entries_from_url(url = '')
    content = get_content_from_url(url)
    return [] if content.blank?
  end

  def latest_entries_from_content(content = '')
    return [] if content.blank?

  end

  private

  def get_content_from_url(url = '')
    return '' if url.blank?
  end
end
