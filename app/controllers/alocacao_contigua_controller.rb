class AlocacaoContiguaController < ApplicationController
  before_action :set_disco, only: [:index, :gravar_bloco, :deletar_bloco, :restaurar, :defragmentar]

  def index
    authorize @disco
  end

  def gravar_bloco
    tipo_bloco = params[:form][:tipo_bloco]
    tamanho_bloco = params[:form][:tamanho_bloco].to_i
    verificar_bloco(tipo_bloco, tamanho_bloco)
  end

  def deletar_bloco
    tipo_bloco = params[:form][:tipo_bloco]
    @disco.update(dados: @disco.dados.gsub(tipo_bloco, '-'))
    @disco.informacoes_disco.find_by(tipo: tipo_bloco).destroy
    redirect_to alocacao_contigua_index_path(@disco), method: :get, notice: 'Bloco deletado com sucesso'
  end

  def restaurar
    @disco.update(dados: '-' * Disco::TAMANHO_DISCO)
    @disco.informacoes_disco.destroy_all
    redirect_to alocacao_contigua_index_path(@disco), method: :get, notice: 'Disco restaurado com sucesso'
  end

  def defragmentar
    @disco.update(dados: @disco.dados.chars.sort.reverse.join)
    redirect_to alocacao_contigua_index_path(@disco), method: :get, notice: 'Disco desfragmentado com sucesso'
  end

  private
  
    def set_disco
      @disco = Disco.find(params[:id])
    end

    def verificar_bloco(tipo_bloco, tamanho_bloco)
      str = '-' * tamanho_bloco
      subs = tipo_bloco * tamanho_bloco

      dados_atualizados = @disco.dados.sub(str, subs)

      if @disco.dados == dados_atualizados || @disco.dados.include?(tipo_bloco)
        redirect_to alocacao_contigua_index_path(@disco), alert: 'Não foi possivel armazenar'
      else
        @disco.update(dados: dados_atualizados)
        descricao = DiscoService.new(tipo_bloco, dados_atualizados).substring_positions
        cor_bloco = "%06x" % (rand * 0xffffff)
        InformacaoDisco.create(disco: @disco, tipo: tipo_bloco, descricao: descricao, cor_bloco: cor_bloco)
        redirect_to alocacao_contigua_index_path(@disco), method: :get, notice: 'Armazenado com sucesso'
      end
    end
  end
