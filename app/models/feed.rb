class Feed < ApplicationRecord
    has_many :entries
    
    validates_presence_of :title, :address
end
