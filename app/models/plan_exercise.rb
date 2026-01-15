
class PlanExercise < ApplicationRecord
  belongs_to :month_plan
  belongs_to :exercise

  validates :month_plan_id, uniqueness: { scope: :exercise_id }
end
