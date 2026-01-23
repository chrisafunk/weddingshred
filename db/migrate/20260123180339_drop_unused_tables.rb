# db/migrate/20240610123456_drop_unused_tables.rb
class DropUnusedTables < ActiveRecord::Migration[7.0]
  def change
    drop_table :monthly_plans, if_exists: true
    drop_table :plan_exercises, if_exists: true
    drop_table :workout_entries, if_exists: true
  end
end
