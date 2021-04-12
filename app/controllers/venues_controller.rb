class VenuesController < ApplicationController
  before_action :authenticate, only: %i[create destroy]

  def index
    @venue = Venue.all
    render json: @venue
  end

  def create
    if @current_user.admin?
      if !(params[:opening_hour] < params[:closing_hour])
        render json: { error_message: 'Invalid opening_hour/closing_hour. Try again!' }
      else
        @venue = Venue.create(name: params[:name], opening_hour: params[:opening_hour],
                              closing_hour: params[:closing_hour])
        if @venue.save
          render json: { message: "#{@venue.name} venue has been created." }
        else
          render json: { message: 'Venue has not been created.' }
        end
      end
    else
      render json: { message: 'To create a venue you should be an admin.' }
    end
  end

  def destroy
    if @current_user.admin?
      @venue = Venue.find_by_name(params[:name])
      if !@venue
        render json: { message: "There is no such venue named #{params[:name]}." }
      else
        @venue.destroy
        render json: { message: 'Venue and all its reservations have been successfully deleted.' }
      end
    else
      render json: { message: 'You are not an admin to delete a venue.' }
    end
  end
end
