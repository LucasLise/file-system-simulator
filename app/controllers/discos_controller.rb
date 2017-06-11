class DiscosController < ApplicationController
  def index
    if !session[:id_usuario]
      inicializar_usuario
    end
  end

  private

    def inicializar_usuario
      @usuario = Usuario.new(nome: SecureRandom.hex(10))
      @usuario.save
      session[:id_usuario] = @usuario.id
      criar_discos
    end

    def criar_discos
      @usuario.discos.create(dados: '-' * Disco::TAMANHO_DISCO, tipo_alocacao: Disco::ALOCACAO_CONTIGUA)
      @usuario.discos.create(dados: '-' * Disco::TAMANHO_DISCO, tipo_alocacao: Disco::ALOCACAO_ENCADEADA)
      @usuario.discos.create(dados: '-' * Disco::TAMANHO_DISCO, tipo_alocacao: Disco::ALOCACAO_INDEXADA)
    end

end
