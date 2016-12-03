class CreateContestants < ActiveRecord::Migration[5.0]
  def change
    create_table :contestants do |t|
      t.belongs_to :pool, null: false
      t.string :first_name, null: false
      t.string :last_name
      t.string :residence
      t.string :description
      t.timestamps
    end
  end
end
