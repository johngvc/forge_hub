class ProjectPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end
    def index?
      true
    end

    def new?
      true
    end

    def create?
      true
    end

    def edit?
      # user ==> current_user
      # record ==> @project
      true
    end

    def update
      true
    end

    def show?
      true
    end

    def destroy?
      true
    end

    def new_join_request?
      true
    end

    def join_request_authorize?
      true
    end

    def join_request_refuse?
      true
    end

    private

    def owner_ou_admin?
      true
    end
end
