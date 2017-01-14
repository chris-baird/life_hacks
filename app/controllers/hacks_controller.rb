class HacksController < ApplicationController
  before_action :set_hack, only: [:show, :edit, :update, :destroy]
  before_action :authorize, except: [:index, :show]
  def index
    @hacks = Hack.all
  end

  def show
    @hack = Hack.find(params[:id])
    @comment = Comment.new
  end

  def new
    @hack = Hack.new
  end

  def edit
    if @hack.user == current_user
      @hack = Hack.find(params[:id])
    else
      redirect_to hacks_path
      flash[:notice] = "Invalid User"
    end
  end

  def create
    @hack = Hack.new(hack_params)
    @hack.user = current_user
    if @hack.save
      flash[:notice] = "Life Hack Created!"
      redirect_to hacks_path
    else
      render 'new'
    end
  end

  def update
    @hack = Hack.find(params[:id])
    if @hack.user == current_user && @hack.update_attributes(hack_params)
      redirect_to hacks_path
      flash[:notice] = "Life Hack Edited!"
    else
      render 'edit'
      flash.now[:notice] = 'Invalid User'
    end
  end

  def destroy
    @hack = Hack.find(params[:id])
    if @hack.user == current_user
      @hack.destroy
      flash[:notice] = "Life Hack Deleted!"
      redirect_to hacks_path
    else
      flash[:notice] = "Invalid User"
      redirect_to hacks_path
    end
  end

  private

  def set_hack
    @hack = Hack.find(params[:id])
  end

  def hack_params
    params.require(:hack).permit(:name, :image, :body)
  end


end
