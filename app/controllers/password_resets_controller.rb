class PasswordResetsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    user.send_password_reset if user
    flash[:info] = "Email sent with password reset instructions."
    redirect_to root_url
  end

  def edit
    unless @user = User.find_by_password_reset_token(params[:id])
      flash[:danger] = "Reset link has expired. Please try again."
      redirect_to new_password_reset_path
    end
  end

  def update
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.password_reset_sent_at < 2.hours.ago
      flash[:danger] = "Password reset has expired. Please try again."
      redirect_to new_password_reset_path
    elsif @user.update_attributes(params.permit![:user])
      flash[:success] = "Password has been reset!"
      redirect_to root_url
    else
      render :edit
    end
  end
end
