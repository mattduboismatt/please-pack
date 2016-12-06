class CreatePicks < ActiveRecord::Migration[5.0]
  def change
    create_table :picks do |t|
      t.belongs_to :entry, null: false
      t.belongs_to :contestant, null: false
      t.timestamps
    end
  end
end
