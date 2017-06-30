class Feed < ApplicationRecord
    has_many :entries
    belongs_to :user
    
    validates_presence_of :title, :address
end
