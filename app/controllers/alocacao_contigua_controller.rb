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
    AlocacaoContiguaService.new(@disco, tipo_bloco).atualizar_disco
    redirect_to alocacao_contigua_index_path(@disco), method: :get, notice: 'Bloco deletado com sucesso'
  end

  def restaurar
    AlocacaoContiguaService.new(@disco).restaurar_disco
    redirect_to alocacao_contigua_index_path(@disco), method: :get, notice: 'Disco restaurado com sucesso'
  end

  def defragmentar
    AlocacaoContiguaService.new(@disco).defragmentar_disco
    redirect_to alocacao_contigua_index_path(@disco), method: :get, notice: 'Disco desfragmentado com sucesso'
  end

  private

    def set_disco
      @disco = Disco.find(params[:id])
      if @disco.try(:tipo_alocacao).eql? Disco::ALOCACAO_CONTIGUA
        @disco
      else
        redirect_to discos_path, alert: 'Selecione um disco'
      end
      @disco
    end
  end
