class BookingsController < ApplicationController
  def index
    @bookings = Booking.where(user_id: current_user)
  end

  def owner_index
    owner_listings = current_user.listings
    @owner_bookings = owner_listings.map(&:bookings).flatten
  end

  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    @booking.listing = Listing.find(params[listing_id])
    if @booking.save
      redirect_to listing_path(@booking.listing)
    else
      render 'new'
    end
  end

  private

  def booking_params
    params.require(:booking).permit(
      :start_date,
      :end_date,
      :approved
    )
  end
end
