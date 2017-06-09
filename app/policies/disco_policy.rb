class DiscoPolicy < ApplicationPolicy
  def index?
    @record.usuario.eql? @user
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
