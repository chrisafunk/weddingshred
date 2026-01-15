
class WorkoutEntry < ApplicationRecord
  belongs_to :user
  belongs_to :exercise
  belongs_to :month_plan

  validates :performed_on, presence: true
  validate :performed_on_within_month_plan
  validate :exercise_belongs_to_month_plan
  validate :at_least_one_metric


  def update_user_streaks
    return unless performed_on.present?

    user.with_lock do
      if user.last_logged_on == performed_on - 1
        user.current_streak += 1
      elsif user.last_logged_on == performed_on
        # already counted today; do nothing
      else
        user.current_streak = 1
      end

      user.longest_streak = [user.longest_streak, user.current_streak].max
      user.last_logged_on = performed_on
      user.save!
    end
  end


  def performed_on_within_month_plan
    return if month_plan.blank? || performed_on.blank?
    errors.add(:performed_on, "must be inside the selected MonthPlan") unless month_plan.includes_date?(performed_on)
  end

  def exercise_belongs_to_month_plan
    return if month_plan.blank? || exercise.blank?
    errors.add(:exercise_id, "is not part of this MonthPlan") unless month_plan.exercises.exists?(exercise.id)
  end

  def at_least_one_metric
    metrics = [sets, reps, weight, duration_minutes, distance_km]
    if metrics.all?(&:blank?)
      errors.add(:base, "Provide at least one metric (sets/reps/weight/duration/distance)")
    end
  end
end
