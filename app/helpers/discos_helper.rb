module DiscosHelper
  def cor_bloco(i)
    @disco.informacoes_disco.find_by(tipo: @disco.dados[i]).try(:cor_bloco)
  end

  def para_deletar
     deletar =  @disco.dados.chars.uniq
     deletar.delete('-')
     deletar.delete('!')
     deletar
  end

  def para_adicionar
    armazenados = @disco.dados.chars.uniq
    ('A'..'Z').to_a - armazenados
  end

  def disco_possui_dados?
    @disco.dados.count('-') < Disco::TAMANHO_DISCO
  end

  def disponivel
    @disco.dados.count('-')
  end

  def usado
     Disco::TAMANHO_DISCO - @disco.dados.count('-')
  end

  def data(dados)
    x = dados.chars.chunk{|e| e}.map{|e| e[1].join }.compact

    cores = {"Disponível" => "#F8F8FF"}

    disco = Array(  x.map do |v|
                      if v[0] == "-"
                        ["Disponível", v.size]
                      else
                       cores[v[0]] =  "##{@disco.informacoes_disco.find_by(tipo: v[0]).cor_bloco}"
                       [v[0], v.size]
                     end
                    end
                  )
    @colors = []
    disco.each do |valor, _|
      @colors << cores[valor]
    end
  end
end
