class StaticPagesController < ApplicationController

  def home
    if logged_in?
      @place  = current_user.place.build
      @feed_items = current_user.feed.paginate(page: params[:page])
      #現在のURLを記憶
		  before_location root_path
    end
  end

  def help
  end

  def about
  end
  
end
