class CreateInformacoesDisco < ActiveRecord::Migration[5.0]
  def change
    create_table :informacoes_disco do |t|
      t.string :tipo
      t.string :descricao

      t.timestamps
    end
  end
end
