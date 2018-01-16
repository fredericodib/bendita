class UsersController < ApplicationController
	before_action :is_admin?
	before_action :is_full_admin?, only: [:delete, :block]
	
	def index
		@users = User.all
	end

	def destroy
		@user = User.find(params[:id])
		@user.destroy
		redirect_to users_path, notice: "usuario apagado com sucesso"
	end

	def block
		@user = User.find(params[:id])
		@user.blocked = !@user.blocked
		@user.save
		if @user.blocked
			redirect_to users_path, notice: "usuario bloqueado com sucesso"
		else
			redirect_to users_path, notice: "usuario desbloqueado com sucesso"
		end
	end
end
