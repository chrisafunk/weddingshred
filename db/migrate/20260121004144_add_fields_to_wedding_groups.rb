# db/migrate/20240610123456_add_fields_to_wedding_groups.rb
class AddFieldsToWeddingGroups < ActiveRecord::Migration[6.1]
  def change
    add_column :wedding_groups, :wedding_date, :date
    add_column :wedding_groups, :location, :string
  end
end
