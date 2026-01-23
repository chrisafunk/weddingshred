class DropMonthPlanTable < ActiveRecord::Migration[8.1]
  def change
    drop_table :month_plans, if_exists: true
  end
end
