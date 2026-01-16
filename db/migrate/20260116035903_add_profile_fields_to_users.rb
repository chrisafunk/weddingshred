# db/migrate/XXXXXXXXXX_add_profile_fields_to_users.rb
class AddProfileFieldsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :relationship_to_couple, :string
  end
end
