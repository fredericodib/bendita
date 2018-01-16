class EventsController < ApplicationController
	before_action :set_event, only: [:show, :edit, :update, :destroy]

	def index
	    @events = Event.where(start: params[:start]..params[:end])
	end

	def show
	end

	def new
	    @event = Event.new
	end

	def edit
	end

	def create
		if !current_user.blocked
		    @event = Event.new(event_params)
		    @event.user = current_user
		    @event.title = "Ocupado" if (@event.title.blank? && current_user.full_admin?)
		    @event.title = current_user.name if @event.title.blank?
		    @event.color = "red" if (@event.color.blank? && current_user.full_admin?)
		    @event.save

		    if !current_user.full_admin?
			    @admins = User.where(status: 'full_admin')
			    CalendarMailer.create_event_notification_user(current_user, @event).deliver_later
			    @admins.each do |a|
			    	CalendarMailer.create_event_notification_admin(a, @event).deliver_later
			    end
			end
		end
	end

	def update
		if (@event.user == current_user || current_user.full_admin?)
		    @event.update(event_params)
		    @event.title = "Ocupado" if (@event.title.blank? && current_user.full_admin?)
		    @event.title = current_user.name if @event.title.blank?
		    @event.color = "red" if (@event.color.blank? && current_user.full_admin?)
		    @event.save

		    if !@event.user.full_admin?
			    @admins = User.where(status: 'full_admin')
			    CalendarMailer.edit_event_notification(@event.user, @event, current_user).deliver_later
			    @admins.each do |a|
			    	CalendarMailer.edit_event_notification(a, @event, current_user).deliver_later
			    end
			end
		end
	end

	def destroy
		if (@event.user == current_user || current_user.full_admin?)
			if !@event.user.full_admin?
			    @admins = User.where(status: 'full_admin')
			    CalendarMailer.delet_event_notification(@event.user, @event, current_user).deliver_later
			    @admins.each do |a|
			    	CalendarMailer.delet_event_notification(a, @event, current_user).deliver_later
			    end
			end
			
	    	@event.destroy
	    end
	end

	def calendar
	end

	private

	def set_event
	    @event = Event.find(params[:id])
	end

	def event_params
	    params.require(:event).permit(:title, :date_range, :start, :end, :color)
	end
end
