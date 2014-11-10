class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.active
        sign_in user
        redirect_back_or user
      else
        user.send_activation
        flash.now[:danger] = 'Your account has not been activated. 
                              We are sending a new activation email. 
                              Please email veganeatsboston@gmail.com 
                              if you do not see an email within 30 minutes.'
        render 'new'
      end
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end
