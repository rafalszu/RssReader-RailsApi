require "deleteable"

class Entry < ApplicationRecord
  include Deletable

  belongs_to :feed
  belongs_to :user

  validates_presence_of :title, :permanent_url, :feed

  def self.update_from_feed(feedjira_rssentries, feed)
    return if feed.nil?

    feedjira_rssentries.each do |rss_entry|
      Entry.find_or_create_by!(permanent_url: rss_entry.url, user_id: feed.user.id, feed_id: feed.id) do |entry|
        entry.read = false
        entry.title = rss_entry.title.sanitize
        entry.summary = rss_entry.summary.sanitize
        entry.content = rss_entry.content.sanitize
        entry.author = rss_entry.author
        entry.published = rss_entry.published
      end
    end
  end
end
