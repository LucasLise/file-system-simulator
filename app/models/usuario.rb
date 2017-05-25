class Usuario < ApplicationRecord
  has_one :disco

  validates :nome, presence: true, length: { minimum: 5 }
end
