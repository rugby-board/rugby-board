class ApplicationController < ActionController::API
  include AuthHelper

  before_action :check_token

  def check_token
    unless params[:token].eql?(token)
      render json: {
        :status => -1,
        :message => "Access denied"
      }
    end
  end
end
