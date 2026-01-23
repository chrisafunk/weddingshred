class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :wedding_group

  scope :group_admins, -> { where(is_group_admin: true) }


end
