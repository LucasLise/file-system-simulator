class AlocacaoContiguaController < ApplicationController
  before_action :set_disco, only: [:index, :gravar_bloco, :deletar_bloco, :restaurar, :defragmentar]

  def index
    authorize @disco
  end

  def gravar_bloco
    tipo_bloco = params[:form][:tipo_bloco]
    tamanho_bloco = params[:form][:tamanho_bloco].to_i
    redirect = AlocacaoContiguaService.new(@disco, tipo_bloco, tamanho_bloco).verificar_bloco
    redirect_to alocacao_contigua_index_path(redirect[:disco]), redirect[:message]
  end

  def deletar_bloco
    tipo_bloco = params[:form][:tipo_bloco]
    @disco.update(dados: @disco.dados.gsub(tipo_bloco, '-'))
    @disco.informacoes_disco.find_by(tipo: tipo_bloco).try(:destroy)
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
  end
