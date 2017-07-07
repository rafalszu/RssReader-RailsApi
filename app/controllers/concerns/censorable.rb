# require ActionView::Helpers

module Censorable
  extend ActiveSupport::Concern

  included do
    before_validation :strip_js
  end
  
  def strip_js
    # go only through the dirty props
    self.changed.each do |prop|
      self[prop] = remove_unsafe_tags(self[prop]) if self[prop].instance_of? String
    end
  end
  
  def remove_unsafe_tags(str)
    doc = Loofah.fragment(str).scrub!(:prune)
    doc.to_s
  end
end
