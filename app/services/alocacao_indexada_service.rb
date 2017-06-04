class AlocacaoIndexadaService < ApplicationService

  def restaurar_disco
    @disco.update(dados: '-' * Disco::TAMANHO_DISCO)
    @disco.informacoes_disco.destroy_all
    @disco.ponteiros.destroy_all
  end

  def atualiza_dados_e_ponteiros
    atualiza_dados_disco
    atualiza_ponteiros
    destroy_informacoes_bloco
  end

  def verificar_bloco
    str = '-' * @tamanho_bloco
    subs = @tipo_bloco * @tamanho_bloco

    if @disco.dados.count('-') < @tamanho_bloco + 1
      { disco: @disco, message: {alert: 'Não foi possivel armazenar'} }
    else
      popular_disco_adiciona_ponteiros
      { disco: @disco, message: {notice: 'Armazenado com sucesso'} }
    end
  end

  private

    def destroy_informacoes_bloco
      @disco.informacoes_disco.find_by(tipo: @tipo_bloco).try(:destroy)
    end

    def atualiza_dados_disco
      @disco.update!(dados: @disco.dados.gsub(@tipo_bloco, '-'))
      apagar = @disco.informacoes_disco.find_by(tipo: @tipo_bloco)
      @disco.dados[apagar.pos_indice] = '-'
      @disco.update!(dados: @disco.dados)
    end

    def atualiza_ponteiros
      posicao = @disco.informacoes_disco.find_by(tipo: @tipo_bloco).pos_indice
      ponteiros = @disco.ponteiros.where(posicao: posicao.to_i)
      ponteiros.map(& :destroy)
    end

    def popular_disco_adiciona_ponteiros
      posicao = @disco.dados.index('-')
      @disco.dados[posicao] = '!'
      for i in 1..@tamanho_bloco
        pos = @disco.dados.index('-')
        @disco.dados[pos] = @tipo_bloco
        Ponteiro.create!(disco: @disco, posicao: posicao, valor: pos)
      end
      @disco.update!(dados: @disco.dados)
      inserir_informacoes_diretorio(posicao)
    end

    def inserir_informacoes_diretorio(posicao)
      descricao = posicoes_substring(@tipo_bloco, @disco.dados)
      cor_bloco = "%06x" % (rand * 0xffffff)
      InformacaoDisco.create(disco: @disco, tipo: @tipo_bloco, descricao: descricao, cor_bloco: cor_bloco, pos_indice: posicao)
    end
end
