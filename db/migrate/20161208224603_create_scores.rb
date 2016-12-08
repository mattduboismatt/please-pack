class CreateScores < ActiveRecord::Migration[5.0]
  def change
    create_table :scores do |t|
      t.integer :points, null: false, default: 1
      t.string :mechanism, null: false
      t.timestamps
    end
  end
end
