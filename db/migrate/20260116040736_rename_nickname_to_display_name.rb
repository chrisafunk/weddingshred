class RenameNicknameToDisplayName < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :nickname, :display_name
  end
end
