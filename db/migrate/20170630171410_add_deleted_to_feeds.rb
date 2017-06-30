class AddDeletedToFeeds < ActiveRecord::Migration[5.1]
  def change
    add_column :feeds, :deleted, :boolean, default: false
  end
end
