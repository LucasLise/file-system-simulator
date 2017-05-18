class Usuario < ApplicationRecord
  has_one :disco

  validates_presence_of :nome
end
