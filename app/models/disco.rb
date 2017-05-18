class Disco < ApplicationRecord
  TAMANHO_DISCO = 10

  belongs_to :usuario
  has_many :informacoes_disco
end
