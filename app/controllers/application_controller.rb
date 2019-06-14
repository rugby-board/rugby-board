class ApplicationController < ActionController::Base
  include AuthHelper

  rescue_from ActionController::RoutingError, with: :not_found
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def check_token
    unless params[:token].eql?(token)
      render json: {
        :status => -1,
        :message => "Access denied"
      }
    end
  end

  protected
  def not_found
    render 'errors/404', status: 404
  end
end
