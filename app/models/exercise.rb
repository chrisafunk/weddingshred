
class Exercise < ApplicationRecord
  has_many :plan_exercises, dependent: :destroy
  has_many :month_plans, through: :plan_exercises
  has_many :workout_entries, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :unit, inclusion: { in: %w[reps minutes kg lb km miles count none], allow_nil: true }
end
