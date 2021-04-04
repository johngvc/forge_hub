class ChatroomPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end

    def index?
      true
    end

    def user_chatrooms?
      true
    end

    def show?
      true
    end

    def new?
      true
    end

    def create?
      true
    end
  end
end
