class Disco < ApplicationRecord
  TAMANHO_DISCO = 200
  ALOCACAO_CONTIGUA = 1
  ALOCACAO_ENCADEADA = 2
  ALOCACAO_INDEXADA = 3

  belongs_to :usuario
  has_many :informacoes_disco
  has_many :ponteiros
end
