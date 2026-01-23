
class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_wedding_groups

  def set_wedding_groups
    @wedding_groups = current_user.memberships
                                  .includes(:wedding_group)
                                  .where.not(status: "pending")
                                  .map(&:wedding_group)

    if @wedding_groups.size == 1
      session[:current_group_id] = @wedding_groups.first.id
    end
  end

  def set_current_group
    session[:current_group_id] = params[:group_id]
    redirect_back fallback_location: root_path
  end

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
