class BookingsController < ApplicationController
  before_action :set_booking, only: [:edit, :update, :destroy]
  before_action :set_listing, only: [:create, :edit, :update]

  def index
    @bookings = Booking.where(user_id: current_user)
  end

  def owner_index
    owner_listings = current_user.listings
    @owner_bookings = owner_listings.map(&:bookings).flatten
  end

  def show
    @listing = Listing.find(params[:listing_id])
    @booking = Booking.find(params[:id])
  end

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

                 #                 root GET    /                                                                                        pages#home
                 #     listing_bookings GET    /listings/:listing_id/bookings(.:format)                                                 bookings#index
                 #                      POST   /listings/:listing_id/bookings(.:format)                                                 bookings#create
                 #  new_listing_booking GET    /listings/:listing_id/bookings/new(.:format)                                             bookings#new
                 # edit_listing_booking GET    /listings/:listing_id/bookings/:id/edit(.:format)                                        bookings#edit
                 #      listing_booking GET    /listings/:listing_id/bookings/:id(.:format)                                             bookings#show
                 #                      PATCH  /listings/:listing_id/bookings/:id(.:format)                                             bookings#update
                 #                      PUT    /listings/:listing_id/bookings/:id(.:format)                                             bookings#update
                 #             listings GET    /listings(.:format)                                                                      listings#index
                 #                      POST   /listings(.:format)                                                                      listings#create
                 #          new_listing GET    /listings/new(.:format)                                                                  listings#new
                 #         edit_listing GET    /listings/:id/edit(.:format)                                                             listings#edit
                 #              listing GET    /listings/:id(.:format)                                                                  listings#show
                 #                      PATCH  /listings/:id(.:format)                                                                  listings#update
                 #                      PUT    /listings/:id(.:format)                                                                  listings#update
                 #                      DELETE /listings/:id(.:format)                                                                  listings#destroy
                 #             bookings GET    /bookings(.:format)                                                                      bookings#owner_index
                 #                      DELETE /bookings/:id(.:format)
