
class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  private

  def require_admin!
    unless current_user&.admin?
      redirect_to root_path, alert: "Not authorized"
    end
  end


  around_action :use_user_time_zone

  def use_user_time_zone(&block)
    Time.use_zone(current_user&.time_zone || "Eastern Time (US & Canada)", &block)
  end


end
