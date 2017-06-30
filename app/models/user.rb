class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  has_many :feeds
  has_many :entries
  
  validates_presence_of :email, :password
  validates_format_of :email, :with => /.+@.+\..+/i
end
