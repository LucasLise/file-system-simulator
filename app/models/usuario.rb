class Usuario < ApplicationRecord
  has_many :discos

  validates :nome, presence: true, length: { minimum: 5 }
end
