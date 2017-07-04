class AddSummaryToEntries < ActiveRecord::Migration[5.1]
  def change
    add_column :entries, :summary, :string
  end
end
