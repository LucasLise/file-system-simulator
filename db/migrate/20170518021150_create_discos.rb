class CreateDiscos < ActiveRecord::Migration[5.0]
  def change
    create_table :discos do |t|
      t.string :dados

      t.timestamps
    end
  end
end
