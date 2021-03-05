class UserPolicy < ApplicationPolicy

  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    true # Somente para testes (João)
  end
end
