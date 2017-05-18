class AddDiscoToInformacaoDisco < ActiveRecord::Migration[5.0]
  def change
    add_reference :informacoes_disco, :disco, foreign_key: true
  end
end
