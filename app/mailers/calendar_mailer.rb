class CalendarMailer < ApplicationMailer

	def create_event_notification_admin(user, event)
		@user = user
		@event = event
		mail(to: @user.email, subject: "Um novo horário foi marcado #{@event.start} - #{@event.end}")
	end

	def create_event_notification_user(user, event)
		@user = user
		@event = event
		mail(to: @user.email, subject: "Um novo horário foi marcado #{@event.start} - #{@event.end}")
	end

	def edit_event_notification(user, event, current)
		@user = user
		@event = event
		@current = current
		mail(to: @user.email, subject: "O horario do estudio foi mudado para #{@event.start} - #{@event.end}")
	end

	def delet_event_notification(user, event, current)
		@user = user
		@event = event
		@current = current
		mail(to: @user.email, subject: "Um evento foi apagado #{@event.start} - #{@event.end}")
	end
end
