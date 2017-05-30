class CreatePonteiros < ActiveRecord::Migration[5.0]
  def change
    create_table :ponteiros do |t|
      t.string :posicao
      t.string :valor

      t.timestamps
    end
  end
end
