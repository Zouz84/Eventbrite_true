class EventsController < ApplicationController
	before_action :signed_in_user

	def index
		@past_events = Event.past
		@future_events = Event.upcoming
	end

	def show
		@event = Event.find(params[:id])
	end

	def new
		@event = Event.new
	end

	def create
		@user = User.find(session[:id])
		@event = @user.events.build(event_params)
		if @event.save
			redirect_to @event
		else
			render :new
		end
	end

	private

	def event_params
		params.require(:event).permit(:name, :description, :address, :date)
	end
end
