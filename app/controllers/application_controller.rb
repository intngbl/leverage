class ApplicationController < ActionController::Base
  protect_from_forgery
  rescue_from CanCan::AccessDenied do |exception|
    # flash[:error] = t('cancan.failure.unauthorized')
    redirect_to root_path, alert: exception.message
  end
end
