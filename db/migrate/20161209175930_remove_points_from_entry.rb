class RemovePointsFromEntry < ActiveRecord::Migration[5.0]
  def change
    remove_column :entries, :points, :integer, null: false, default: 0
  end
end
