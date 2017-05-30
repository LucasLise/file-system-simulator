class UsuariosController < ApplicationController
  before_action :set_usuario, only: [:show, :edit, :update, :destroy]

  def new
    @usuario = Usuario.new
  end

  def create
    respond_to do |format|
      if Usuario.find_by(nome: params[:usuario][:nome]).present?
        @usuario = Usuario.find_by(nome: params[:usuario][:nome])
        session[:id_usuario] = @usuario.id
        format.html { redirect_to discos_path, notice: 'Autenticado'}
      else
        @usuario = Usuario.new(usuario_params)
        if @usuario.save
          session[:id_usuario] = @usuario.id
          criar_discos
          format.html { redirect_to discos_path, notice: 'Autenticado'}
        else
          format.html { render :new }
          format.json { render json: object.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  private

    def criar_discos
      @usuario.discos.create(dados: '-' * Disco::TAMANHO_DISCO, tipo_alocacao: 1)
      @usuario.discos.create(dados: '-' * Disco::TAMANHO_DISCO, tipo_alocacao: 2)
      @usuario.discos.create(dados: '-' * Disco::TAMANHO_DISCO, tipo_alocacao: 3)
    end

    def usuario_params
      params.require(:usuario).permit(:nome)
    end
end
