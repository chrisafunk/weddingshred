class CreateMonthPlans < ActiveRecord::Migration[8.0]
  def change
    create_table :month_plans do |t|
      t.string :title
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
