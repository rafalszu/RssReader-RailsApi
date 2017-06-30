require "deleteable"

class Entry < ApplicationRecord
  include Deletable

  belongs_to :feed
  belongs_to :user
    
  validates_presence_of :title, :permanent_url, :feed
end
