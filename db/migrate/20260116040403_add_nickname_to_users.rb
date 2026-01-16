# db/migrate/XXXXXXXXXX_add_nickname_to_users.rb
class AddNicknameToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :nickname, :string
  end
end