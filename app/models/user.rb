
class User < ApplicationRecord

  validates :password, length: { minimum: 7 }, allow_blank: true
  validates :password, confirmation: true, allow_blank: true
  validates :first_name, :last_name, :relationship_to_couple, :email, :password, presence: true



  # Devise modules—adjust to your preference
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  enum :role, { member: 0, super_admin: 1 }

  has_many :workout_entries, dependent: :destroy
  has_many :memberships
  has_many :wedding_groups, through: :memberships

  def role_display_name
    case role
    when "super_admin"
      "Super Admin"
    when "group_admin"
      "Group Admin"
    else
      "Member"
    end
  end

  def time_zone_or_default
    time_zone.presence || Rails.application.config.time_zone
  end


end

