class Admin::UsersController < ApplicationController

  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    required_fields = %i[first_name last_name email relationship_to_couple role password password_confirmation]
    required_fields.each do |field|
      if @user.send(field).blank?
        @user.errors.add(field, "can't be blank")
      end
    end

    # Email format validation
    unless @user.email =~ /\A[^@\s]+@[^@\s]+\z/
      @user.errors.add(:email, "is not a valid email address")
    end

    if @user.password != @user.password_confirmation
      @user.errors.add(:password_confirmation, "does not match password")
    end

    if @user.errors.any?
      render :new, status: :unprocessable_entity
    elsif @user.save
      redirect_to admin_users_path, notice: "User created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @user = User.find(params[:id])
    required_fields = %i[first_name last_name relationship_to_couple role]
    required_fields.each do |field|
      if params[:user][field].blank?
        @user.errors.add(field, "can't be blank")
      end
    end

    if @user.errors.any?
      render :edit, status: :unprocessable_entity
    elsif @user.update(user_params)
      redirect_to admin_users_path, notice: "User updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.memberships.destroy_all # Adjust if association is named differently
    @user.destroy
    redirect_to admin_users_path, notice: "User and all associated memberships deleted."
  end


  private

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :display_name,
      :email,
      :relationship_to_couple,
      :password,
      :password_confirmation,
      :role
    )
  end

end
