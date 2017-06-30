require "deleteable"

class Feed < ApplicationRecord
  include Deletable
  
  has_many :entries
  belongs_to :user
    
  validates_presence_of :title, :address
end
