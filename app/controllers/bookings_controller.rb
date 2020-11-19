class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update, :destroy]
  before_action :set_listing, only: [:show, :new, :create, :edit, :update]

  def index
    @bookings = Booking.where(user_id: current_user)
    owner_listings = current_user.listings
    @owner_bookings = owner_listings.map(&:bookings).flatten
  end

  def show; end

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    @booking.listing = @listing
    if @booking.save
      redirect_to listing_booking_path(@listing, @booking)
    else
      render 'new'
    end
  end

  def edit; end

  def update
    @booking.listing = @listing
    if @booking.update(booking_params)
      redirect_to bookings_path
    else
      render 'edit'
    end
  end

  def destroy
    @booking.destroy
    redirect_to bookings_path
  end

  private

  def booking_params
    params.require(:booking).permit(
      :start_date,
      :end_date,
      :approved
    )
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def set_listing
    @listing = Listing.find(params[:listing_id])
  end
end
