class StaticPagesController < ApplicationController

  def home
    if logged_in?
      @place  = current_user.place.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def help
  end

  def about
  end
  
end
