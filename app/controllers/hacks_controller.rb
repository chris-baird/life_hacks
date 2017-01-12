class HacksController < ApplicationController

  def index
    @hacks = Hack.all
  end

  def show
    @hack = Hack.find(params[:id])
  end

  def new
    @hack = Hack.new
  end

  def edit
    @hack = Hack.find(params[:id])
  end

  def create
    @hack = Hack.new(hack_params)
    if @hack.save
      flash[:notice] = "Life Hack Created!"
      redirect_to hacks_path
    else
      render 'new'
    end
  end

  def update
    @hack = Hack.find(params[:id])
    if @hack.update_attributes(hack_params)
      redirect_to hacks_path
    else
      render 'edit'
    end
  end

  def destroy
    @hack = Hack.find(params[:id])
    @hack.destroy
    flash[:success] = "Life Hack Deleted!"
    redirect_to hacks_path
  end

  private

  def hack_params
    params.require(:hack).permit(:name, :image, :body)
  end


end
