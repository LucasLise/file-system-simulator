class AlocacaoIndexadaController < ApplicationController
  before_action :set_disco, only: [:index, :restaurar, :gravar_bloco, :deletar_bloco]

  def index
    # @context = UserContext.new(@disco)
    authorize @disco
  end

  def gravar_bloco
    tipo_bloco = params[:form][:tipo_bloco]
    tamanho_bloco = params[:form][:tamanho_bloco].to_i
    verificar_bloco(tipo_bloco, tamanho_bloco)
  end

  def deletar_bloco
    @tipo_bloco = params[:form][:tipo_bloco]
    atualiza_ponteiros
    atualiza_dados_disco
    @disco.informacoes_disco.find_by(tipo: @tipo_bloco).try(:destroy)
    redirect_to alocacao_indexada_index_path(@disco), notice: 'Bloco deletado com sucesso'
  end

  def restaurar
    @disco.update(dados: '-' * Disco::TAMANHO_DISCO)
    @disco.informacoes_disco.destroy_all
    @disco.ponteiros.destroy_all
    redirect_to alocacao_indexada_index_path(@disco), notice: 'Disco restaurado com sucesso'
  end

  private

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

    def verificar_bloco(tipo_bloco, tamanho_bloco)
      str = '-' * tamanho_bloco
      subs = tipo_bloco * tamanho_bloco

      if @disco.dados.count('-') < tamanho_bloco + 1
        redirect_to alocacao_indexada_index_path(@disco), alert: 'Não foi possível armazenar'
      else
        posicao = @disco.dados.index('-')
        @disco.dados[posicao] = '!'
        for i in 1..tamanho_bloco
          pos = @disco.dados.index('-')
          @disco.dados[pos] = tipo_bloco
          Ponteiro.create!(disco: @disco, posicao: posicao, valor: pos)
        end
        @disco.update!(dados: @disco.dados)
        descricao = DiscoService.new(tipo_bloco, @disco.dados).substring_positions
        cor_bloco = "%06x" % (rand * 0xffffff)
        InformacaoDisco.create(disco: @disco, tipo: tipo_bloco, descricao: descricao, cor_bloco: cor_bloco, pos_indice: posicao)
        redirect_to alocacao_indexada_index_path(@disco), notice: 'Armazenado com sucesso'
      end
    end

    def set_disco
      @disco = Disco.find(params[:id])
    end
end
