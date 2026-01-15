
# db/migrate/XXXXXXXXXXXX_add_leaderboard_indexes_to_workout_entries.rb
class AddLeaderboardIndexesToWorkoutEntries < ActiveRecord::Migration[7.1]
  def change
    # Speeds up grouping and distinct day counting per user & plan
    add_index :workout_entries, [:user_id, :month_plan_id, :performed_on], name: "index_entries_user_plan_day"
    add_index :workout_entries, :performed_on
  end
end
