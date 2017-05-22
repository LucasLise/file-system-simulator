class DiscoPolicy < ApplicationPolicy
  def contigua?
    possui_permissao?
  end

  private

  def possui_permissao?
    user.disco.eql? record
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
