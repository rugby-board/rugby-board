module AuthHelper
  def token
    ENV["ADMIN_TOKEN"] || "12ffbb6"
  end
end
