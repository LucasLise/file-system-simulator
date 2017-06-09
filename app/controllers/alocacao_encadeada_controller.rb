class AlocacaoEncadeadaController < ApplicationController
  before_action :set_disco, only: [:index, :restaurar, :gravar_bloco, :deletar_bloco]

  def index
    authorize @disco
  end

  def gravar_bloco
    tipo_bloco = params[:form][:tipo_bloco]
    tamanho_bloco = params[:form][:tamanho_bloco].to_i
    redirect = AlocacaoEncadeadaService.new(@disco, tipo_bloco, tamanho_bloco).verificar_bloco
    redirect_to alocacao_encadeada_index_path(redirect[:disco]), redirect[:message]
  end

  def deletar_bloco
    tipo_bloco = params[:form][:tipo_bloco]
    AlocacaoEncadeadaService.new(@disco, tipo_bloco).atualiza_disco_e_ponteiros
    redirect_to alocacao_encadeada_index_path(@disco), notice: 'Bloco deletado com sucesso'
  end

  def restaurar
    AlocacaoEncadeadaService.new(@disco).restaurar_disco
    redirect_to alocacao_encadeada_index_path(@disco), notice: 'Disco restaurado com sucesso'
  end

  private

  def set_disco
    @disco = Disco.find(params[:id])
    if @disco.try(:tipo_alocacao).eql? Disco::ALOCACAO_ENCADEADA
      @disco
    else
      redirect_to discos_path, alert: 'Selecione um disco'
    end
    @disco
  end
end
