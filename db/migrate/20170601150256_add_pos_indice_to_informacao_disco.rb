class AddPosIndiceToInformacaoDisco < ActiveRecord::Migration[5.0]
  def change
    add_column :informacoes_disco, :pos_indice, :integer
  end
end
