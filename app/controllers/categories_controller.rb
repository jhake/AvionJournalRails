class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end
  def show
    @category = Category.find(params[:id])
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
        redirect_to categories_path
    else
        render :new
    end
  end
  def edit
    @category = Category.find(params[:id])        
  end
  def update
    @category = Category.find(params[:id])  
    if @category.update(id: params[:id], name: params[:category][:name], description: params[:category][:description])
      redirect_to categories_path
    else
      render :edit
    end
  end
  def delete
    @category = Category.find(params[:id])  
    if @category.destroy
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