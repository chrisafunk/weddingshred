
class MonthPlan < ApplicationRecord
  has_many :plan_exercises, dependent: :destroy
  has_many :exercises, through: :plan_exercises
  has_many :workout_entries, dependent: :restrict_with_error

  accepts_nested_attributes_for :plan_exercises, allow_destroy: true

  validates :title, :start_date, :end_date, presence: true
  validate :covers_full_month

  scope :current, -> { where("start_date <= ? AND end_date >= ?", Date.current, Date.current) }

  def covers_full_month
    return if start_date.blank? || end_date.blank?
    if start_date.beginning_of_month != start_date || end_date.end_of_month != end_date
      errors.add(:base, "MonthPlan should start at the first day and end at the last day of a month")
    end
  end

  def includes_date?(date)
    (start_date..end_date).cover?(date)
  end

  def year_month
    start_date.strftime("%Y-%m")
  end
end
