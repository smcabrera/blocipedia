class WikiPolicy < ApplicationPolicy
  def index?
  end

  def destroy?
    user.id == record.user.id
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      wikis = []
      if user.role == 'admin'
        wikis = scope.all # If the user is an admin, show them all the wikis
      elsif user.role == 'premium'
        all_wikis = scope.all
        all_wikis.each do |wiki|
          if wiki.public? || wiki.user == user || wiki.users.include?(user)
            wikis << wiki # If the user is premium, only show them public wikis, or their own wikis, or wikis on which they are collaborators
          end
        end
      else # This should just be 'free' (standard) users
        all_wikis = scope.all
        all_wikis.each do |wiki|
          if wiki.public? || wiki.users.include?(user)
            wikis << wiki
          end
        end
      end
      wikis # Return the wikis array we've built up
    end
  end
end
