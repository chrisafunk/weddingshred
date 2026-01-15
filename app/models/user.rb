
class User < ApplicationRecord
  # Devise modules—adjust to your preference
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  enum :role, { user: 0, admin: 1 }


  has_many :workout_entries, dependent: :destroy

  def admin?
    role == "admin"
  end

  def time_zone_or_default
    time_zone.presence || Rails.application.config.time_zone
  end


end

