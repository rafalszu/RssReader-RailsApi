class CreateEntries < ActiveRecord::Migration[5.1]
  def change
    create_table :entries do |t|
      t.string :title
      t.string :permanent_url
      t.string :content
      t.boolean :read
      t.belongs_to :feed
      
      t.timestamps
    end
  end
end
