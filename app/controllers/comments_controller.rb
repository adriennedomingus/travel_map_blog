class CommentsController < ApplicationController
  def create
    if current_user
      @comment = @commentable.comments.new(comment_params)
      @comment.user = current_user
      @comment.save
      flash[:success] = "Your comment has been posted!"
      if @commentable.class == Blog
        redirect_to blog_path(@commentable.slug)
      elsif @commentable.class == Photo
        redirect_to user_photo_path(@commentable.user.nickname, @commentable.slug)
      end
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
