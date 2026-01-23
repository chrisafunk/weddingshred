
# db/migrate/20260123150000_extend_exercises_for_fitness_attributes.rb
class ExtendExercisesForFitnessAttributes < ActiveRecord::Migration[8.0]
  def change
    # Structured choices (as integer enums)
    add_column :exercises, :movement_pattern,     :integer, null: false, default: 0
    add_column :exercises, :exercise_type,        :integer, null: false, default: 0
    add_column :exercises, :starting_position,    :integer, null: false, default: 0
    add_column :exercises, :plane_of_motion,      :integer, null: false, default: 0
    add_column :exercises, :technical_complexity, :integer, null: false, default: 0

    # Multi-select attributes (PostgreSQL arrays)
    add_column :exercises, :primary_muscles,   :string, array: true, default: []
    add_column :exercises, :secondary_muscles, :string, array: true, default: []
    add_column :exercises, :equipment,         :string, array: true, default: []
    add_column :exercises, :purposes,          :string, array: true, default: []

    # Programming variables
    add_column :exercises, :tempo,        :string
    add_column :exercises, :reps_min,     :integer
    add_column :exercises, :reps_max,     :integer
    add_column :exercises, :sets_min,     :integer
    add_column :exercises, :sets_max,     :integer
    add_column :exercises, :rest_seconds, :integer

    # Intensity
    add_column :exercises, :load_min_kg, :decimal, precision: 6, scale: 2
    add_column :exercises, :load_max_kg, :decimal, precision: 6, scale: 2
    add_column :exercises, :target_rpe,  :decimal, precision: 3, scale: 1
    add_column :exercises, :rir,         :integer

    # Technique / safety / metadata
    add_column :exercises, :unilateral,       :boolean, null: false, default: false
    add_column :exercises, :requires_spotter, :boolean, null: false, default: false
    add_column :exercises, :range_of_motion,  :text
    add_column :exercises, :joint_angles,     :jsonb, default: {}
    add_column :exercises, :contraindications, :text
    add_column :exercises, :coaching_cues,     :text
    add_column :exercises, :video_url,         :string

    # Helpful indexes for arrays/JSON
    add_index :exercises, :primary_muscles,   using: :gin
    add_index :exercises, :secondary_muscles, using: :gin
    add_index :exercises, :equipment,         using: :gin
    add_index :exercises, :purposes,          using: :gin
    add_index :exercises, :joint_angles,      using: :gin

    # Data quality (Postgres check constraints)
    reversible do |dir|
      dir.up do
        execute <<~SQL
          ALTER TABLE exercises
          ADD CONSTRAINT chk_reps_range CHECK (reps_min IS NULL OR reps_max IS NULL OR reps_min <= reps_max),
          ADD CONSTRAINT chk_sets_range CHECK (sets_min IS NULL OR sets_max IS NULL OR sets_min <= sets_max),
          ADD CONSTRAINT chk_load_range CHECK (load_min_kg IS NULL OR load_max_kg IS NULL OR load_min_kg <= load_max_kg),
          ADD CONSTRAINT chk_rest_nonneg CHECK (rest_seconds IS NULL OR rest_seconds >= 0);
        SQL
      end
    end
  end
end
