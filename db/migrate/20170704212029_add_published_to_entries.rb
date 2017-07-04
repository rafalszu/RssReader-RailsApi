class AddPublishedToEntries < ActiveRecord::Migration[5.1]
  def change
    add_column :entries, :published, :datetime
  end
end
