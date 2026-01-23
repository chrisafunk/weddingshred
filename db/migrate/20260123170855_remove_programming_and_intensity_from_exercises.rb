
# db/migrate/20260123160000_remove_programming_and_intensity_from_exercises.rb
class RemoveProgrammingAndIntensityFromExercises < ActiveRecord::Migration[8.0]
  def change
    # Programming variables
    remove_column :exercises, :tempo, :string
    remove_column :exercises, :reps_min, :integer
    remove_column :exercises, :reps_max, :integer
    remove_column :exercises, :sets_min, :integer
    remove_column :exercises, :sets_max, :integer
    remove_column :exercises, :rest_seconds, :integer

    # Intensity
    remove_column :exercises, :load_min_kg, :decimal, precision: 6, scale: 2
    remove_column :exercises, :load_max_kg, :decimal, precision: 6, scale: 2
    remove_column :exercises, :target_rpe,  :decimal, precision: 3, scale: 1
    remove_column :exercises, :rir,         :integer
  end
end
