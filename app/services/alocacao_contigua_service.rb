class AlocacaoContiguaService < ApplicationService

  def verificar_bloco
    str = '-' * @tamanho_bloco
    subs = @tipo_bloco * @tamanho_bloco

    dados_atualizados = @disco.dados.sub(str, subs)

    if @disco.dados == dados_atualizados || @disco.dados.include?(@tipo_bloco)
      { disco: @disco, message: { alert: 'Não foi possivel armazenar'} }
    else
      atualiza_disco(dados_atualizados)
      { disco: @disco, message: {notice: 'Armazenado com sucesso'} }
    end
  end

  def atualizar_disco
    @disco.update(dados: @disco.dados.gsub(@tipo_bloco, '-'))
    @disco.informacoes_disco.find_by(tipo: @tipo_bloco).try(:destroy)
  end

  def restaurar_disco
    @disco.update(dados: '-' * Disco::TAMANHO_DISCO)
    @disco.informacoes_disco.destroy_all
  end

  def defragmentar_disco
    @disco.update(dados: @disco.dados.chars.sort.reverse.join)
  end

  private

    def atualiza_disco(dados_atualizados)
      @disco.update(dados: dados_atualizados)
      inserir_informacoes_diretorio(dados_atualizados)
    end

    def inserir_informacoes_diretorio(dados_atualizados)
      descricao = posicoes_substring(@tipo_bloco, dados_atualizados)
      cor_bloco = "%06x" % (rand * 0xffffff)
      InformacaoDisco.create(disco: @disco, tipo: @tipo_bloco, descricao: descricao, cor_bloco: cor_bloco)
    end

end
