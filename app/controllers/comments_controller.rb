class CommentsController < ApplicationController

  def index
    @comments = Comment.all
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def new
    @comment = Comment.new
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def create
    @comment = Comment.new(comment_params)
    @hack = Hack.find(params[:hack_id])
    @comment.user = current_user
    @comment.hack = @hack
    if @comment.save
      flash[:notice] = "Comment Created!"
      redirect_to @hack
    else
      render 'new'
    end
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.user == current_user && @comment.update_attributes(comment_params)
      redirect_to @comment.hack
      flash[:notice] = "Comment Edited!"
    else
      render 'edit'
      flash.now[:notice] = 'Invalid User'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    hack = @comment.hack
    if @comment.user == current_user
      @comment.destroy
      flash[:notice] = "Comment Deleted!"
      redirect_to hack
    else
      flash[:notice] = "Invalid User"
      redirect_to hack
    end
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
