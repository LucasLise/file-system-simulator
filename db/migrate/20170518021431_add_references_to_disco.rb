class AddReferencesToDisco < ActiveRecord::Migration[5.0]
  def change
    add_reference :discos, :usuario, foreign_key: true
  end
end
