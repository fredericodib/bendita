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
	    @event = Event.new(event_params)
	    @event.user = current_user
	    @event.title = "Ocupado" if (@event.title.blank? && current_user.full_admin?)
	    @event.title = current_user.name if @event.title.blank?
	    @event.color = "red" if (@event.color.blank? && current_user.full_admin?)
	    @event.save
	end

	def update
		if (@event.user == current_user || current_user.full_admin?)
		    @event.update(event_params)
		    @event.title = "Ocupado" if (@event.title.blank? && current_user.full_admin?)
		    @event.title = current_user.name if @event.title.blank?
		    @event.color = "red" if (@event.color.blank? && current_user.full_admin?)
		    @event.save
		end
	end

	def destroy
		if (@event.user == current_user || current_user.full_admin?)
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
