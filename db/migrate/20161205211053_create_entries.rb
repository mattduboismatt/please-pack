class CreateEntries < ActiveRecord::Migration[5.0]
  def change
    create_table :entries do |t|
      t.belongs_to :pool, null: false
      t.string :name, null: false
      t.integer :points, null: false, default: 0

      t.timestamps
    end
  end
end
