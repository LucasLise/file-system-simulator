class AddTipoAlocacaoToDisco < ActiveRecord::Migration[5.0]
  def change
    add_column :discos, :tipo_alocacao, :integer
  end
end
