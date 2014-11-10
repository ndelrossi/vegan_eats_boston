class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)

    if authenticated_and_active?(user)
      sign_in user
      redirect_back_or user
    else
      handle_bad_sign_in_on(user)
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end

  private

  def authenticated_and_active?(user)
    user && user.authenticate(params[:session][:password]) && user.active
  end

  def handle_bad_sign_in_on(user)
    if user && !user.active
      user.send_activation
      flash.now[:danger] = 'Your account has not been activated. 
                            We are sending a new activation email. 
                            Please email veganeatsboston@gmail.com 
                            if you do not see an email within 30 minutes.'
    else
      flash.now[:danger] = 'Invalid email/password combination'
    end
  end
end
