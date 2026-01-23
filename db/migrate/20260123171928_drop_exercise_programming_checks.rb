
# db/migrate/20260123160500_drop_exercise_programming_checks.rb
class DropExerciseProgrammingChecks < ActiveRecord::Migration[8.0]
  def up
    execute <<~SQL
      ALTER TABLE exercises
      DROP CONSTRAINT IF EXISTS chk_reps_range,
      DROP CONSTRAINT IF EXISTS chk_sets_range,
      DROP CONSTRAINT IF EXISTS chk_load_range,
      DROP CONSTRAINT IF EXISTS chk_rest_nonneg;
    SQL
  end

  def down
    # no-op (or re-add them if you want full reversibility)
  end
end
