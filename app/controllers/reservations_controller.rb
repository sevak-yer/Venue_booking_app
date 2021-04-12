class ReservationsController < ApplicationController
  before_action :authenticate, only: [:create]

  def create
    if !(params[:checkin]<params[:checkout])
        render json: { error_message: "Invalid checkin/checkout hours. Try again!" }
    else    
    if !@current_user.admin?
      if Time.now > Date.parse(params[:date])
        render json: { error_message: "Your reservation date should be at least tomorrow's date." }
      elsif @venue = Venue.find_by_name(params[:venue])
        if @venue.closing_hour.strftime('%H:%M') < params[:checkout] || @venue.opening_hour.strftime('%H:%M') > params[:checkin]
          render json: {
            error_message: "the opening and closing hours of #{@venue.name} are #{@venue.opening_hour.strftime('%H:%M')} and #{@venue.closing_hour.strftime('%H:%M')} respectively. Try again!"
          }
        else
          status = true
          reserved = @venue.reservations
          reserved.each do |reserve|
            next unless reserve.date === Date.parse(params[:date]) && ((reserve.checkin.strftime('%H:%M') <= params[:checkin] && reserve.checkout.strftime('%H:%M') >= params[:checkout]) ||
                   (reserve.checkin.strftime('%H:%M') >= params[:checkin] && reserve.checkin.strftime('%H:%M') <= params[:checkout]) ||
                   (reserve.checkout.strftime('%H:%M') >= params[:checkin] && reserve.checkout.strftime('%H:%M') <= params[:checkout]))

            render json: { error_message: "#{@venue.name} is reserved from #{reserve.checkin.strftime('%H:%M')} to #{reserve.checkout.strftime('%H:%M')}, try again!" }
            status = false
            break
          end
          if status
            reservation = @current_user.reservations.create(venue: @venue)
            reservation.date = params[:date]
            reservation.checkin = params[:checkin]
            reservation.checkout = params[:checkout]
            reservation.save
            render json: reservation
          end
        end
      else
        render json: {
          error_message: "There is no available venue with the name: #{params[:venue]}."
        }
      end
    else
      render json: {
        error_message: 'Admins can not make reservations.'
      }
    end
  end  
  end
end
