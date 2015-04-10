class WikiPolicy < ApplicationPolicy
  def index?
  end

  def destroy?
    user.id == record.user.id
  end

end
