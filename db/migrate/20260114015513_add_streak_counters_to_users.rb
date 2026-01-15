
# db/migrate/XXXXXXXXXXXX_add_streak_counters_to_users.rb
class AddStreakCountersToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :current_streak, :integer, null: false, default: 0
    add_column :users, :longest_streak, :integer, null: false, default: 0
    add_column :users, :last_logged_on, :date
  end
end
