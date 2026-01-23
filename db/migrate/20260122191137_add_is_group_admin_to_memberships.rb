class AddIsGroupAdminToMemberships < ActiveRecord::Migration[7.0]
  def change
    add_column :memberships, :is_group_admin, :boolean, default: false, null: false
  end
end