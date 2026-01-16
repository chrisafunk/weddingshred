class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    user_params = profile_params
    user_params.delete(:email) # Prevent email change

    if user_params[:password].present?
      # Update with password fields
      if @user.update(user_params)
        redirect_to edit_profile_path, notice: "Profile updated successfully."
      else
        flash[:error] = "There was a problem updating your profile."
        render :edit
      end
    else
      # Update without password fields
      if @user.update(user_params.except(:password, :password_confirmation))
        redirect_to edit_profile_path, notice: "Profile updated successfully."
      else
        flash[:error] = "There was a problem updating your profile."
        render :edit
      end
    end
  end

  private

  def profile_params
    params.require(:user).permit(
      :display_name, :first_name, :last_name,
      :relationship_to_couple, :password, :password_confirmation
    )
  end
end
