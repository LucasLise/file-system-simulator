class AlocacaoContiguaService < ApplicationService
  def initialize(disco, tipo_bloco, tamanho_bloco)
    @disco = disco
    @tipo_bloco = tipo_bloco
    @tamanho_bloco = tamanho_bloco
  end

  def verificar_bloco
    str = '-' * @tamanho_bloco
    subs = @tipo_bloco * @tamanho_bloco

    dados_atualizados = @disco.dados.sub(str, subs)

    if @disco.dados == dados_atualizados || @disco.dados.include?(@tipo_bloco)
      { disco: @disco, message: { alert: 'Não foi possivel armazenar'} }
    else
      atualiza_disco(dados_atualizados)
      inserir_informacoes_diretorio(dados_atualizados)
      { disco: @disco, message: {notice: 'Armazenado com sucesso'} }
    end
  end

  private

    def atualiza_disco(dados_atualizados)
      @disco.update(dados: dados_atualizados)
    end

    def inserir_informacoes_diretorio(dados_atualizados)
      descricao = posicoes_substring(@tipo_bloco, dados_atualizados)
      cor_bloco = "%06x" % (rand * 0xffffff)
      InformacaoDisco.create(disco: @disco, tipo: @tipo_bloco, descricao: descricao, cor_bloco: cor_bloco)
    end

end
