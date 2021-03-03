class ProjectPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
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
      owner?
    end

    def update
      owner?
    end

    def show?
      true
    end

    def destroy?
      owner?
    end


    private

    def owner?
      record.user == user
    end
  end
end
