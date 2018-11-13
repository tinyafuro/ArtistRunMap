class PlacesController < ApplicationController
	
	before_action :logged_in_user, only: [:create, :edit, :update, :destroy]
	before_action :correct_user,   only: [:edit, :update, :destroy]

	def index
		@places = Place.paginate(page: params[:page])
		#現在のURLを記憶
		before_location places_path
	end

	def show
		@place = Place.find(params[:id])
	end

	def create
		@place = current_user.place.build(place_params)
		if @place.save
			flash[:success] = "Place created!"
			redirect_to root_url
		else
			@feed_items = []
			render 'static_pages/home'
		end
	end

	def edit
		# @place = Place.find(params[:id])
	end

	def update
		# @place = User.find(params[:id])
		if @place.update_attributes(place_params)
			flash[:success] = "Place updated"
			redirect_to @place
		else
			render 'edit'
		end
	end

	def destroy
		@place.destroy
		flash[:success] = "Place deleted"
		# redirect_to request.referrer || root_url
		redirect_to redirect_before_url
	end

	private

		def place_params
			params.require(:place).permit(:name, :address, :picture)
		end

		def correct_user
			@place = current_user.place.find_by(id: params[:id])
      redirect_to root_url if @place.nil?
		end

end
