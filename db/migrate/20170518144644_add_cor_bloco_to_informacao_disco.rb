class AddCorBlocoToInformacaoDisco < ActiveRecord::Migration[5.0]
  def change
    add_column :informacoes_disco, :cor_bloco, :string
  end
end
