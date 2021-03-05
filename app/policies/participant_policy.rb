class ParticipantPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end
  def index
    true
  end
  def create?
    true
  end
  def edit?
    
  end
  def destroy
    true
  end
end
