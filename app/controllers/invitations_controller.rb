class InvitationsController < ApplicationController
  before_action :signed_in_user

  def new
  	@invitation = Invitation.new
  end

  def create
  	@invitation = Invitation.new
  	@invitation.attended_event_id = params[:invitation][:attended_event_id]
  	@invitation.attendee_id = User.find_by(name: params[:invitation][:attendee_id]).id
  	if @invitation.save
  		redirect_back(fallback_location: @invitation.attended_event_id)
  	else
  		render :new
  	end
  end
end
