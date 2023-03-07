class CommentsController < ApplicationController

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(items_params)
    @comment.user_id = current_user.id
    @recipe = Recipe.find(params[:comment][:recipe_id])
    @comment.recipe_id = @recipe.id
    if @comment.save
      flash[:success] = "Your comment has been posted"
      redirect_to recipe_path(@recipe)
    else
      render "recipes/show", status: :unprocessable_entity
      flash[:alert] = "Error: " + @recipe.errors.full_messages.join(", ")
    end
  end

  private
  def items_params
    params.require(:comment).permit(:content, :rating)
  end
end
