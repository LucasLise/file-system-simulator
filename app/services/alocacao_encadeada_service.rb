class AlocacaoEncadeadaService < ApplicationService

  def verificar_bloco
    str = '-' * @tamanho_bloco
    subs = @tipo_bloco * @tamanho_bloco

    if @disco.dados.count('-') < @tamanho_bloco
      { disco: @disco, message: { alert: 'Não foi possivel armazenar'} }
    else
      popular_disco_adiciona_ponteiros
      inserir_informacoes_diretorio
      { disco: @disco, message: {notice: 'Armazenado com sucesso'} }
    end
  end

  def atualiza_ponteiros
    posicoes = posicoes_substring(@tipo_bloco, @disco.dados).split ','
    posicoes.collect!(& :to_i)
    posicoes.collect!{ |i| @disco.ponteiros.find_by(posicao: i).try(:destroy) }
  end

  private

  def inserir_informacoes_diretorio
    descricao = posicoes_substring(@tipo_bloco, @disco.dados)
    cor_bloco = "%06x" % (rand * 0xffffff)
    InformacaoDisco.create(disco: @disco, tipo: @tipo_bloco, descricao: descricao, cor_bloco: cor_bloco)
  end

  def popular_disco_adiciona_ponteiros
    for i in 1..@tamanho_bloco
      posicao = @disco.dados.index('-')
      @disco.dados[posicao] = @tipo_bloco
      if i < @tamanho_bloco
        proxima = @disco.dados.index('-')
      else
        proxima = '*'
      end
      Ponteiro.create!(disco: @disco, posicao: posicao, valor: proxima.to_s)
    end
    @disco.update!(dados: @disco.dados)
  end

end
