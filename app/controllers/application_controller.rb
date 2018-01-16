class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  def is_admin?
  	if !current_user
    	redirect_to unauthenticated_root_path, alert: "Você não possui permissão para acessar essa págine!"
	elsif (!current_user.full_admin? && !current_user.half_admin?)
    	redirect_to authenticated_root_path, alert: "Você não possui permissão para acessar essa págine!"
	end
  end


  def is_full_admin?
  	if !current_user
    	redirect_to unauthenticated_root_path, alert: "Você não possui permissão para acessar essa págine!"
	elsif (!current_user.full_admin?)
    	redirect_to authenticated_root_path, alert: "Você não possui permissão para acessar essa págine!"
	end
  end
end
