class AddDiscoToPonteiro < ActiveRecord::Migration[5.0]
  def change
    add_reference :ponteiros, :disco, foreign_key: true
  end
end
