class UsersController < ApplicationController
  include ApplicationHelper
  before_action :signed_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]
  
  def show
    @user_profile = UserProfile.new(params)
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation
      flash[:info] = "Please follow the link in your email 
                      to activate your account. You will not 
                      be able to log in until you activate."
      redirect_to root_url
    else
      render 'new'
    end
  end
  
  def activate
    @user = User.find_by_activation_token!(params[:id])
    if @user.update_attribute(:active, true)
      sign_in @user
      flash[:success] = "Your account has been activated. 
                         Welcome to Vegan Eats Boston!"
      redirect_to @user
    else
      flash[:danger] = "Activation failed. Please email 
                        us at veganeatsboston@gmail.com"
      redirect_to root_url
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation, :avatar)
    end

    # Before filters

    def correct_user
      @user = User.find(params[:id])
      unless current_user?(@user) || current_user.admin?
        redirect_to(root_url)
      end
    end
end
