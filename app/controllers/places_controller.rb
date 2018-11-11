class PlacesController < ApplicationController
	
	before_action :logged_in_user, only: [:create, :destroy]
	before_action :correct_user,   only: :destroy

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

	def destroy
		@place.destroy
		flash[:success] = "Place deleted"
		redirect_to request.referrer || root_url
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
