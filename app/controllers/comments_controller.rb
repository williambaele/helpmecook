class CommentsController < ApplicationController

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(items_params)
    @comment.user_id = current_user.id
    @comment.recipe =  Recipe.find(params[:id])
    if @comment.save
      flash[:success] = "Your comment has been posted"
      redirect_to root_path
    else
      flash[:alert] = "Error ! Try again"
      render :new, status: :unprocessable_entity
    end
  end

  private

  def items_params
    params.require(:comment).permit(:content, :rating)
  end
end
