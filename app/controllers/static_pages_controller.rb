class StaticPagesController < ApplicationController
  include ApplicationHelper

  def home
    @home_page = Homepage.new(params)
  end

  def about
  end
end
