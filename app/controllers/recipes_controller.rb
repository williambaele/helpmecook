class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all
    if params[:query].present?
      @recipes = Recipe.search_by_title_description(params[:query])
    else
    @recipes
    end
  end
  def show

  end
  def new
    @recipe = Recipe.new
  end
  def create
    @recipe = Recipe.new(items_params)
    @recipe.user_id = current_user.id
    if @recipe.save
      flash[:success] = "Your recipe has been created"
      redirect_to root_path
    else
      flash[:alert] = "Error ! Try again"
      render :new, status: :unprocessable_entity
    end
  end

  private

  def items_params
    params.require(:recipe).permit(:title, :description)
  end
end
