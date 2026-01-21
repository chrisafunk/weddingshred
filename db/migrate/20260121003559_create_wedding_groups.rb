class CreateWeddingGroups < ActiveRecord::Migration[8.1]
  def change
    create_table :wedding_groups do |t|
      t.string :name

      t.timestamps
    end
  end
end
