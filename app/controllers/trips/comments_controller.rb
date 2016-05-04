class Trips::CommentsController < CommentsController
  before_action :set_commentable

  private
    def set_commentable
      @commentable = Trip.find(params[:id])
    end
end
