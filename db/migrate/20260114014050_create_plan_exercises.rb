class CreatePlanExercises < ActiveRecord::Migration[8.0]
  def change
    create_table :plan_exercises do |t|
      t.references :month_plan, null: false, foreign_key: true
      t.references :exercise, null: false, foreign_key: true
      t.integer :target_sets
      t.integer :target_reps
      t.decimal :target_weight

      t.timestamps
    end
  end
end
