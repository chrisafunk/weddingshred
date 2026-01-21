# app/models/wedding_group.rb
class WeddingGroup < ApplicationRecord
  has_many :memberships
  has_many :users, through: :memberships

  validates :name, :wedding_date, :location, presence: true

  def has_group_admin?
    memberships.where(role: "group_admin").exists?
  end
end
