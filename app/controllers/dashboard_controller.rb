
class DashboardController < ApplicationController
  def index
    @current_group = WeddingGroup.find_by(id: session[:current_group_id])
    if @current_group
      membership = @current_group.memberships.find_by(user_id: current_user.id)
      @is_group_admin = membership&.is_group_admin?
    else
      @is_group_admin = false
    end

  end
end
