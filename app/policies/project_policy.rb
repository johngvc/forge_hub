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

    def update?
      owner_ou_admin?
    end

    def show?
      create?
    end

    def destroy?
      owner_ou_admin?
    end


    private

    def owner_ou_admin?
      record.user == user
    end
end
