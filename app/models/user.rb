class User < ApplicationRecord
  has_many :feeds
  has_many :entries
  has_one :login
  
  validates_format_of :email, :with => /.+@.+\..+/i
end
