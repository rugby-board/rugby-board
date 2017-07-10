module AuthHelper
  def check_token
    unless params[:token].eql?(token)
      flash[:warning] = "No permission as an admin."
      redirect_to root_url
    end
  end

  def token
    ENV["ADMIN_TOKEN"] || "12ffbb6"
  end
end
