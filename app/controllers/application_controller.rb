require "application_responder"

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  rescue_from ActionController::RoutingError, with: :not_found
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  
  self.responder = ApplicationResponder
  respond_to :html

  protected
  def not_found
    render 'errors/404', status: 404
  end
end
