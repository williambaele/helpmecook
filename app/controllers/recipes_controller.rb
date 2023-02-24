class RecipesController < ApplicationController
  def index
    @recipes = Recipe.includes(:user)
    @total_recipes = Recipe.count
    if params[:query].present?
      @recipes = Recipe.search_by_title_description(params[:query])
    else
    @recipes
    end
  end
  def show
    @recipe = Recipe.find(params[:id])
    @author = @recipe.user.pseudo
  end
  def new
    @recipe = Recipe.new
  end
  def create
    @recipe = Recipe.new(items_params)
    @recipe.user_id = current_user.id
    if @recipe.save
      flash[:success] = "Your recipe has been created"
      redirect_to recipe_path(@recipe)
    else
      flash[:alert] = "Error ! Try again"
      render :new, status: :unprocessable_entity
    end
  end

  private

  def items_params
    params.require(:recipe).permit(:title, :description, :people, :difficulty, :recipe_type, :budget, :time)
  end
end
