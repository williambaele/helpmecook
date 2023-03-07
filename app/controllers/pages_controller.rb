class PagesController < ApplicationController
  def index
    @recipes = Recipe.all
  end
  def publications
    @recipes = current_user.recipes
  end
end
