# app/models/wedding_group.rb
class WeddingGroup < ApplicationRecord
  has_many :memberships, foreign_key: :wedding_group_id, dependent: :destroy

end