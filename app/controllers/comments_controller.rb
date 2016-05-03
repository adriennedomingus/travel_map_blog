class CommentsController < ApplicationController
  def create
    if current_user
      @comment = @commentable.comments.new(comment_params)
      @comment.user = current_user
      @comment.save
      flash[:success] = "Your comment has been posted!"
      redirect_to blog_path(@commentable.slug)
    else
      flash[:danger] = "You must be logged in to leave a comment. Please log in and try again."
      redirect_to blog_path(@commentable.slug)
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:body)
    end
end
