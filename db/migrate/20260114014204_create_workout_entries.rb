class CreateWorkoutEntries < ActiveRecord::Migration[8.0]
  def change
    create_table :workout_entries do |t|
      t.references :user, null: false, foreign_key: true
      t.references :exercise, null: false, foreign_key: true
      t.references :month_plan, null: false, foreign_key: true
      t.date :performed_on
      t.integer :sets
      t.integer :reps
      t.decimal :weight
      t.integer :duration_minutes
      t.decimal :distance_km
      t.text :notes

      t.timestamps
    end
  end
end
