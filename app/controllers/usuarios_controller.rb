class UsuariosController < ApplicationController
  before_action :set_usuario, only: [:show, :edit, :update, :destroy]

  def new
    @usuario = Usuario.new
  end

  def create
    respond_to do |format|
      if Usuario.find_by(nome: params[:usuario][:nome]).present?
        @usuario = Usuario.find_by(nome: params[:usuario][:nome])
        format.html { redirect_to usuario_disco_path(@usuario, @usuario.disco), notice: 'Logado'}
      else
        @usuario = Usuario.new(usuario_params)
        if @usuario.save
          @disco = Disco.new
          @disco.usuario = @usuario
          @disco.dados = '-' * Disco::TAMANHO_DISCO
          @disco.save
          format.html { redirect_to usuario_disco_path(@usuario, @disco), notice: 'Logado'}
        else
          format.html { render :new }
          format.json { render json: object.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  private

    def usuario_params
      params.require(:usuario).permit(:nome)
    end
end
