require 'deleteable'
require 'censorable'

class Entry < ApplicationRecord
  include Deletable
  include Censorable
  
  belongs_to :feed
  belongs_to :user

  validates_presence_of :title, :permanent_url, :feed

end
