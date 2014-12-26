class DiscussionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  def index
    @discussions = Discussion.includes(:user).all
  end
  def show
    @discussion = Discussion.includes(:user, comments: :user).find params[:id]
    @comment = Comment.new
  end
  def new
    @discussion = Discussion.new
    @discussion.comments.build
  end
  def create
    @discussion = Discussion.new discussion_params
    @discussion.user = current_user
    if @discussion.save
      flash[:notice] = "New Discussion Succesfully Created"
      redirect_to discussion_path @discussion
    else
      flash[:error] = "New Discussion should have Title and Description"
      render :new
    end
  end
  def edit
    @discussion = Discussion.find params[:id]
  end
  def update
    @discussion = Discussion.find params[:id]
    if @discussion.update_attributes discussion_params
      flash[:notice] = 'Discussion Update Successfully'
      redirect_to discussion_path @discussion
    else
      flash[:error] = 'Error updating Discussion, check your attributes please'
      render :edit
    end
  end
  def destroy
    @discussion = Discussion.find params[:id]
    if @discussion.destroy
        flash[:notice] = "Discussion was succesfully destroyed"
        redirect_to discussions_path
      else
        flash[:error] = "Discussion can't be destroyed!"
        render :show
      end
  end


  def discussion_params
    params.require(:discussion).permit(:title,:description)
  end
  def comment_params
    params.require(:comment).permit(:content)
  end
end
