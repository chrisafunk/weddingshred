
# db/migrate/20260123174500_add_thumbnail_url_to_exercises.rb
class AddThumbnailUrl < ActiveRecord::Migration[8.0]
  def change
    add_column :exercises, :thumbnail_url, :string
    add_index  :exercises, :thumbnail_url
  end
end
