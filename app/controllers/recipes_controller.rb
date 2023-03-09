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
      if params[:budget].present?
        case params[:budget]
        when "Cheap"
          @recipes = @recipes.where(budget: "Cheap")
        when "Economic"
          @recipes = @recipes.where(budget: "Economic")
        when "Middle"
          @recipes = @recipes.where(budget: "Middle")
        when "Expensive"
          @recipes = @recipes.where(budget: "Expensive")
        when "Fancy"
          @recipes = @recipes.where(budget: "Fancy")
        end
      elsif params[:people].present?
        case params[:people]
        when "1"
          @recipes = @recipes.where(people: "1")
        when "2"
          @recipes = @recipes.where(people: "2")
        when "3"
          @recipes = @recipes.where(people: "3")
        when "4"
          @recipes = @recipes.where(people: "4")
        when "5"
          @recipes = @recipes.where(people: "5")
        when "6+"
          @recipes = @recipes.where("people >= ?", 6)
        end
      elsif params[:difficulty].present?
        case params[:difficulty]
        when "1"
          @recipes = @recipes.where(difficulty: "1")
        when "2"
          @recipes = @recipes.where(difficulty: "2")
        when "3"
          @recipes = @recipes.where(difficulty: "3")
        when "4"
          @recipes = @recipes.where(difficulty: "4")
        when "5"
          @recipes = @recipes.where(difficulty: "5")
        when "6"
          @recipes = @recipes.where(difficulty: "6")
        when "7"
          @recipes = @recipes.where(difficulty: "7")
        when "8"
          @recipes = @recipes.where(difficulty: "8")
        when "9"
          @recipes = @recipes.where(difficulty: "9")
        when "10"
          @recipes = @recipes.where(difficulty: "10")
        end
        if @recipes.empty?
          flash[:alert] = "No results found for #{params[:difficulty]}/10 recipe"
        end
      elsif params[:time].present?
        case params[:time]
        when "Less than 10 minutes"
          @recipes = @recipes.where("time < ?", 10)
        when "Less than 20 minutes"
          @recipes = @recipes.where("time < ?", 20)
        when "Less than 30 minutes"
          @recipes = @recipes.where("time < ?", 30)
        when "Less than 1 hour"
          @recipes = @recipes.where("time < ?", 60)
        end

      elsif params[:rating].present?
        @recipes = @recipes.joins(:comments)
                           .group('recipes.id')
                           .having('AVG(comments.rating) >= ?', params[:rating].to_i)
      elsif params[:recipe_type].present?
        case params[:recipe_type]
        when "Starter"
          @recipes = @recipes.where(recipe_type: "Starter")
        when "Lunch"
          @recipes = @recipes.where(recipe_type: "Lunch")
        when "Diner"
          @recipes = @recipes.where(recipe_type: "Diner")
        when "Dessert"
          @recipes = @recipes.where(recipe_type: "Dessert")
        when "Snack"
          @recipes = @recipes.where(recipe_type: "Snack")
        end
      end
    end
  end


  def edit
    @recipe = Recipe.find(params[:id])
    authorize @recipe
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
    authorize @recipe
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
    authorize @recipe
  end
  def create
    @recipe = Recipe.new(items_params)
    @recipe.user_id = current_user.id
    authorize @recipe

    if @recipe.save
      flash[:success] = "Your recipe has been created"
      redirect_to recipe_path(@recipe)
    else
      flash[:alert] = "Error: " + @recipe.errors.full_messages.join(", ")
      render :new, status: :unprocessable_entity
    end
  end

  private

  def items_params
    params.require(:recipe).permit(:title, :description, :people, :difficulty, :recipe_type, :budget, :time, :photo)
  end
end
