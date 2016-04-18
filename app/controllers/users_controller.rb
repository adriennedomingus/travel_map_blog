class UsersController < ApplicationController
  def show
    @user = User.find_by(nickname: params[:nickname]) || current_user
  end
end
