class CommentsController < ApplicationController

  def destroy
    @comment = Comment.find params[:id]
    discussion = @comment.discussion
    if @comment.destroy
      flash[:notice] = "Comment was succesfully destroyed"
    else
      flash[:error] = "Comment can't be destroyed!"
    end
    redirect_to discussion_path discussion
  end
end
