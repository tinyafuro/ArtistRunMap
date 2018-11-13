class StaticPagesController < ApplicationController

  def home
    if logged_in?
      @place  = current_user.place.build
      @feed_items = current_user.feed.paginate(page: params[:page])
      #現在のURLを記憶
      before_location root_path
    else
      #すべてのPlaceをGoogleMapに表示
      @places = Place.all
      @hash = Gmaps4rails.build_markers(@places) do |place, marker|
        #緯度経度が取得できているものだけMapへ表示させる
        if place.latitude && place.longitude
          marker.lat place.latitude
          marker.lng place.longitude
          marker.infowindow place.name
        end
      end
    end
  end

  def help
  end

  def about
  end

  def unity
    @places = Place.all
  end
  
end
