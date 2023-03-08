class RecipePolicy < ApplicationPolicy
  def new?
    user.present?
  end

  def create?
    user.present?
  end
  def edit?
    user == record.user
  end
  def destroy?
    user == record.user
  end
end
