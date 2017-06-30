class Entry < ApplicationRecord
    belongs_to :feed
    
    validates_presence_of :title, :permanent_url, :feed
end
