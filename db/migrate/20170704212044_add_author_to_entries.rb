class AddAuthorToEntries < ActiveRecord::Migration[5.1]
  def change
    add_column :entries, :author, :string
  end
end
