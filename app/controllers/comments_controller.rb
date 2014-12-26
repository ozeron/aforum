class CommentsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  def create
    @discussion = Discussion.find params[:discussion_id]
    @comment =  Comment.initialize_with comment_params, user: current_user, discussion: @discussion
    respond_to do |format|
      if @comment.save
        flash.now[:notice] = "New Comment succesfully added"
        format.js { render layout: false }
        format.html { redirect_to discussion_path @discussion }
      else
        flash.now[:error] = "Error adding new Comment. Content shouldn't be empty!"
        format.html { render :show }
      end
    end
  end
  def edit
    @comment = Comment.find params[:id]
    respond_to do |format|
      format.js {render layout: false}
    end
  end
  def update
    @comment = Comment.find params[:id]
    respond_to do |format|
      if @comment.update comment_params
        flash.now[:notice] = "Comment was succesfully edited!"
        format.js {render layout: false}
        #format.html { redirect_to discussion_path @comment.discussion }
      else
        flash.now[:error] = "Error updating comment. Content shouldn't be empty."
        @comment.reload
        format.js {render layout: false}
      end
    end
  end
  def destroy
    @comment = Comment.find params[:id]
    discussion = @comment.discussion
    respond_to do |format|
      if @comment.destroy
        format.js {render layout: false}
        flash.now[:notice] = "Comment was succesfully destroyed"
      else
        flash.now[:error] = "Comment can't be destroyed!"
      end
      format.html { redirect_to discussion_path discussion }
    end
  end
  def comment_params
    params.require(:comment).permit(:content)
  end
end
