class AddPonteirosToDisco < ActiveRecord::Migration[5.0]
  def change
    add_column :discos, :ponteiros, :string
  end
end
