class RecipesController < ApplicationController
  def index
    @recipes = Recipe.includes(:user)
    @total_recipes = Recipe.count
    if params[:query].present?
      @recipes = Recipe.search_by_title_description(params[:query])
      if @recipes.empty?
        flash[:alert] = "No results found for '#{params[:query]}'"
      end
    else
      @recipes
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end
  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update(items_params)
      flash[:success] = "Your recipe has been updated"
      redirect_to recipe_path(@recipe)
    else
      flash[:alert] = "Error ! Try again"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.comments.destroy_all
    if @recipe.destroy
      flash[:success] = "Your item has been deleted"
      redirect_to my_publications_path
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
    @author = @recipe.user.pseudo
    @comments = @recipe.comments.includes(:user)
    @comment = Comment.new # Initialize @comment variable with a new Comment object
    @total_comments = @recipe.comments.count
    @rating_global = @comments.average(:rating) || 0
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
    params.require(:recipe).permit(:title, :description, :people, :difficulty, :recipe_type, :budget, :time, :photo)
  end
end
