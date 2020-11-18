class ListingsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  def index
    @listings = Listing.all
  end

  def new
    @listing = Listing.new
  end

  def create
    @listing = Listing.new(listing_params)
    @listing.user = current_user
    if @listing.save
      redirect_to listing_path(@listing)
    else
      render 'new'
    end
  end

  private

  def listing_params
    params.require(:listing).permit(
      :description,
      :title,
      :address_line_1,
      :address_line_2,
      :postcode,
      :city,
      :available,
      :rate,
      photos: []
    )
  end
end
