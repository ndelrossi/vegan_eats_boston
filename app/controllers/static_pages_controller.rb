class StaticPagesController < ApplicationController
  def home
  end

  def places
  end

  def about
  end

  def admin
    redirect_to(root_url) unless current_user.admin?
  end
end
