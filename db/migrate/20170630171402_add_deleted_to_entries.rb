class AddDeletedToEntries < ActiveRecord::Migration[5.1]
  def change
    add_column :entries, :deleted, :boolean, default: false
  end
end
