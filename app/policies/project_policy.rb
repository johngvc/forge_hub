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

    def show?
      true
    end
  end
end
