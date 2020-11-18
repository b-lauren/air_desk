class BookingsController < ApplicationController
  before_action :set_booking, only: [:edit, :update, :destroy]
  before_action :set_listing, only: [:new, :create, :edit, :update ]

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
    @booking.listing = @listing
    if @booking.save
      redirect_to listing_path(@booking.listing)
    else
      render 'new'
    end
  end

  def edit; end

  def update
    @booking.listing = @listing
    if @booking.update(booking_params)
      redirect_to listing_booking_path(@booking)
    else
      render 'edit'
    end
  end

  def destroy
    @booking.destroy
    redirect_to root_path
  end

  private

  def booking_params
    params.require(:booking).permit(
      :start_date,
      :end_date
    )
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def set_listing
    @listing = Listing.find(params[:listing_id])
  end
end
