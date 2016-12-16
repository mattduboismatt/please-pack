class AddEliminatedToContestants < ActiveRecord::Migration[5.0]
  def change
    add_column :contestants, :eliminated, :boolean, null: false, default: false
  end
end
