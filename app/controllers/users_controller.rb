class UsersController < ApplicationController
  before_filter :authenticate_user!

  load_resource
  authorize_resource except: [:show, :joined_campaigns]

  def index
    @search = User.search(params[:q])
    @users = @search.result
  end

  def update
    if @user.update_attributes(params[:user], :as => :admin)
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end

  def destroy
    unless @user == current_user
      @user.destroy
      redirect_to users_path, :notice => "User deleted."
    else
      redirect_to users_path, :notice => "Can't delete yourself."
    end
  end

  def joined_campaigns
    if @user.has_role? :tweeter
      @campaigns = @user.joined_campaigns
    else
      redirect_to user_path(@user)
    end
  end
end

