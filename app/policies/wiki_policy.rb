class WikiPolicy < ApplicationPolicy
  def index?
  end

  def delete?
    user.id == record.user_id
  end

end
