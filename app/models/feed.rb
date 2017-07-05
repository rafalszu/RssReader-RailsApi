require "deleteable"
require 'rss_helper'

class Feed < ApplicationRecord
  include Deletable

  has_many :entries
  belongs_to :user

  validates_presence_of :title, :address

  def update_from_feed
    return if self.id.nil? || self.address.blank?

    rss_entries = RssHelper.latest_entries_from_url(self.address)
    rss_entries.each do |rss_entry|
      Entry.find_or_create_by!(permanent_url: rss_entry.url, user_id: self.user.id, feed_id: self.id) do |entry|
        entry.read = false
        entry.title = rss_entry.title
        entry.summary = rss_entry.summary
        entry.content = rss_entry.content
        entry.author = rss_entry.author
        entry.published = rss_entry.published
      end
    end
  end
end
