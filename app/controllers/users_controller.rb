class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!
  before_action :set_user, only: %i[edit update destroy make_admin]
  after_action :verify_policy_scoped, only: :index

  def index
    @users = policy_scope(User)
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to users_path, notice: "User updated successfully."
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path, alert: "User deleted successfully."
  end

  def make_admin
    authorize @user, :make_admin?
    if @user.update(role: :admin)
      redirect_to users_path, notice: "User has been granted admin privileges."
    else
      redirect_to users_path, alert: "Failed to update user role."
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :full_name, :role)
  end

  def authorize_admin!
    authorize User
  end
end
