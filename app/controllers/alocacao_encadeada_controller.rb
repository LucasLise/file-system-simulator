class AlocacaoEncadeadaController < ApplicationController
  before_action :set_disco, only: [:index, :restaurar, :gravar_bloco, :deletar_bloco]

  def index
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
    @disco.update!(dados: @disco.dados.gsub(@tipo_bloco, '-'))
    @disco.informacoes_disco.find_by(tipo: @tipo_bloco).try(:destroy)
    redirect_to alocacao_encadeada_index_path(@disco), notice: 'Bloco deletado com sucesso'
  end

  def restaurar
    @disco.update(dados: '-' * Disco::TAMANHO_DISCO)
    @disco.informacoes_disco.destroy_all
    @disco.ponteiros.destroy_all
    redirect_to alocacao_encadeada_index_path(@disco), notice: 'Disco restaurado com sucesso'
  end

  private

    def atualiza_ponteiros
      posicoes = DiscoService.new(@tipo_bloco, @disco.dados).substring_positions.split ','
      posicoes.collect!(& :to_i)
      posicoes.collect!{ |i| @disco.ponteiros.find_by(posicao: i).destroy }
    end

    def verificar_bloco(tipo_bloco, tamanho_bloco)
      str = '-' * tamanho_bloco
      subs = tipo_bloco * tamanho_bloco

      if @disco.dados.count('-') < tamanho_bloco
        redirect_to alocacao_encadeada_index_path(@disco), alert: 'Não foi possível armazenar'
      else
        for i in 1..tamanho_bloco
          posicao = @disco.dados.index('-')
          @disco.dados[posicao] = tipo_bloco
          if i < tamanho_bloco
            proxima = @disco.dados.index('-')
          else
            proxima = '*'
          end
          Ponteiro.create!(disco: @disco, posicao: posicao, valor: proxima.to_s)
        end
        @disco.update!(dados: @disco.dados)
        descricao = DiscoService.new(tipo_bloco, @disco.dados).substring_positions
        cor_bloco = "%06x" % (rand * 0xffffff)
        InformacaoDisco.create(disco: @disco, tipo: tipo_bloco, descricao: descricao, cor_bloco: cor_bloco)
        redirect_to alocacao_encadeada_index_path(@disco), notice: 'Armazenado com sucesso'
      end
    end

    def set_disco
      @disco = Disco.find(params[:id])
    end
end
