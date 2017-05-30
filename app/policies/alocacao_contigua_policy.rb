class AlocacaoContiguaPolicy < ApplicationPolicy
  def contigua?
    possui_permissao?(1)
  end

  private

  def possui_permissao?(tipo)
    user.discos.find_by(tipo_alocacao: tipo).eql? record
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
