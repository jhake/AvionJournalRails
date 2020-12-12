class CategoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @categories = Category.all
  end
  def show
    @category = Category.find(params[:id])
    @tasks = Task.where(category_id: @category.id)
    puts params
  end
  def new
    @category = Category.new
  end
  def create
    @category = Category.new #(category_params)
    @category.name = params[:category][:name]
    @category.description = params[:category][:description]
    if @category.save
        flash[:success] = "Successfully created '#{@category.name}'!"
        redirect_to categories_path
    else
        flash.now[:error] = "Invalid inputs!"
        render :new
    end
  end
  def edit
    @category = Category.find(params[:id])        
  end
  def update
    @category = Category.find(params[:id])  
    if @category.update(id: params[:id], name: params[:category][:name], description: params[:category][:description])
      flash[:success] = "Successfully edited '#{@category.name}'!"
      redirect_to categories_path
    else
      flash.now[:error] = "Invalid inputs!"
      render :edit
    end
  end
  def destroy
    @category = Category.find(params[:id])  
    if @category.destroy
        flash[:success] = "Successfully deleted '#{@category.name}'!"
        redirect_to categories_path
    else
        render :edit
    end
  end
  private
  #strong parameter
  def category_params
    params.require(:category).permit(:name, :description)
  end
end