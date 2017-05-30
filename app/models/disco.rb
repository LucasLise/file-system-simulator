class Disco < ApplicationRecord
  TAMANHO_DISCO = 20

  belongs_to :usuario
  has_many :informacoes_disco
  has_many :ponteiros
end
