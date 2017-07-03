module Deletable
  extend ActiveSupport::Concern

  included do
    default_scope { where(deleted: false) }
  end

  def delete!
    update_attributes!(deleted: true)
  end

  def delete
    update_attributes(deleted: true)
  end
end
