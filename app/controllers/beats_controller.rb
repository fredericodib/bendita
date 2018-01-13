class BeatsController < ApplicationController
	def index
		@beat = Beat.new
		@beats = current_user.beats
	end

	def create
		redirect_to beats_path
	end
end
