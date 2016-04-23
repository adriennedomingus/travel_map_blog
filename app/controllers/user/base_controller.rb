class User::BaseController < ApplicationController

  def require_user
    render file: "/public/404" unless current_user
  end

end
