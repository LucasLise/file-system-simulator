class ApplicationController < ActionController::Base
  protect_from_forgery
  include Pundit

 rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

 def current_user
   Usuario.find(session[:id_usuario])
 end

 private

 def user_not_authorized
   flash[:alert] = "Você não possui permissão"
   redirect_to(request.referrer || root_path)
 end
end
