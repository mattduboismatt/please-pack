class CreateContestantScores < ActiveRecord::Migration[5.0]
  def change
    create_table :contestant_scores do |t|
      t.belongs_to :contestant, null: false
      t.belongs_to :score, null: false
      t.timestamps
    end
  end
end
