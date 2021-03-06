class PrototypesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :user_post, only: [:edit]
  def index
    @prototype = Prototype.all
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments
    
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototypes_params)
    if @prototype.save
    redirect_to root_path
    else
      render :edit
    end
  end

  def edit
    @prototype = Prototype.find(params[:id])
  end

  def update
       @prototype = Prototype.find(params[:id])
    if @prototype.update(prototypes_params)
       redirect_to prototype_path(@prototype)
    else
       render :edit
    end
  end

  def destroy
    @prototype = Prototype.find(params[:id])
    @prototype.destroy
    redirect_to root_path(@prototype)
  end


  private

  def prototypes_params
  params.require(:prototype).permit(:title ,:catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  def user_post
    @prototype = Prototype.find(params[:id])
    redirect_to root_path unless current_user == @prototype.user
  end
  
end