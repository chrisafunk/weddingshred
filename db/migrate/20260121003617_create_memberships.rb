class CreateMemberships < ActiveRecord::Migration[8.1]
  def change
    create_table :memberships do |t|
      t.references :user, null: false, foreign_key: true
      t.references :wedding_group, null: false, foreign_key: true
      t.string :role
      t.string :status

      t.timestamps
    end
  end
end
