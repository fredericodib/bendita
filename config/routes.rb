Rails.application.routes.draw do
  devise_for :users, :controllers => {:sessions => "users/sessions", :registrations => "users/registrations"}

  authenticated :user do
  	root 'pages#home', as: :authenticated_root
  end

  unauthenticated do
    root to: redirect('/users/sign_in'), as: :unauthenticated_root
  end
end
