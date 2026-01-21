class RemoveRoleFromMemberships < ActiveRecord::Migration[8.1]
  def change
    remove_column :memberships, :role, :string
  end
end
