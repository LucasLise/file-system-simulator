# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170601150256) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "discos", force: :cascade do |t|
    t.string   "dados"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "usuario_id"
    t.integer  "tipo_alocacao"
    t.string   "ponteiros"
    t.index ["usuario_id"], name: "index_discos_on_usuario_id", using: :btree
  end

  create_table "informacoes_disco", force: :cascade do |t|
    t.string   "tipo"
    t.string   "descricao"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "disco_id"
    t.string   "cor_bloco"
    t.integer  "pos_indice"
    t.index ["disco_id"], name: "index_informacoes_disco_on_disco_id", using: :btree
  end

  create_table "ponteiros", force: :cascade do |t|
    t.string   "posicao"
    t.string   "valor"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "disco_id"
    t.index ["disco_id"], name: "index_ponteiros_on_disco_id", using: :btree
  end

  create_table "usuarios", force: :cascade do |t|
    t.string   "nome"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "discos", "usuarios"
  add_foreign_key "informacoes_disco", "discos"
  add_foreign_key "ponteiros", "discos"
end
