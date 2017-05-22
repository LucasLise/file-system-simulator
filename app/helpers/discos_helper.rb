module DiscosHelper
  def cor_bloco(i)
    @disco.informacoes_disco.find_by(tipo: @disco.dados[i]).try(:cor_bloco)
  end
end
