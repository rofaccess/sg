# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140217165721) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "asientos_contable", force: true do |t|
    t.integer  "ejercicio_contable_id",                           null: false
    t.string   "numero",                limit: 15,  default: "",  null: false
    t.string   "concepto",              limit: 100, default: "",  null: false
    t.datetime "fecha",                                           null: false
    t.decimal  "monto_total",                       default: 0.0, null: false
    t.string   "numero_doc_com",        limit: 15,  default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "asientos_contable_detalle", force: true do |t|
    t.integer  "asiento_contable_id",                         null: false
    t.integer  "cuenta_contable_id",                          null: false
    t.string   "tipo_partida_doble",  limit: 5, default: "",  null: false
    t.decimal  "monto",                         default: 0.0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "asientos_modelo", force: true do |t|
    t.string   "concepto",   limit: 100, default: "", null: false
    t.string   "origen",     limit: 50,  default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "asientos_modelo_detalle", force: true do |t|
    t.integer  "asiento_modelo_id",                          null: false
    t.integer  "cuenta_contable_id",                         null: false
    t.string   "tipo_partida_doble", limit: 5,  default: "", null: false
    t.string   "valor",              limit: 50, default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ciudades", force: true do |t|
    t.string   "nombre",     limit: 50, default: "", null: false
    t.integer  "estado_id",                          null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "ciudades", ["nombre"], name: "index_ciudades_on_nombre", unique: true, using: :btree

  create_table "componentes_categoria", force: true do |t|
    t.string   "nombre",     limit: 50, default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "componentes_categoria_proveedores", id: false, force: true do |t|
    t.integer "componente_categoria_id", null: false
    t.integer "proveedor_id",            null: false
  end

  add_index "componentes_categoria_proveedores", ["componente_categoria_id", "proveedor_id"], name: "categorias_proveedores", using: :btree

  create_table "compras_cuenta_corriente", force: true do |t|
    t.integer  "proveedor_id",                 null: false
    t.datetime "fecha_creacion",               null: false
    t.decimal  "saldo",          default: 0.0, null: false
    t.decimal  "monto_debito",   default: 0.0
    t.decimal  "monto_credito",  default: 0.0
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "compras_cuenta_corriente_cuota", force: true do |t|
    t.integer  "compra_cuenta_corriente_factura_id",                         null: false
    t.string   "cuota_numero",                       limit: 3, default: "",  null: false
    t.datetime "fecha_vencimiento",                                          null: false
    t.datetime "fecha_pago"
    t.decimal  "importe_cuota",                                default: 0.0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "compras_cuenta_corriente_factura", force: true do |t|
    t.integer  "compra_cuenta_corriente_id",                         null: false
    t.integer  "factura_compra_id",                                  null: false
    t.decimal  "saldo_factura",                        default: 0.0, null: false
    t.string   "cuotas",                     limit: 3, default: "",  null: false
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "condiciones_pago", force: true do |t|
    t.string   "nombre",     limit: 7, default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "configuraciones", force: true do |t|
    t.string   "nombre",              limit: 50,  default: "", null: false
    t.string   "direccion",           limit: 100, default: "", null: false
    t.string   "simbolo_moneda",      limit: 3,   default: "", null: false
    t.string   "email",               limit: 150, default: ""
    t.string   "telefono1",           limit: 50,  default: "", null: false
    t.string   "telefono2",           limit: 50,  default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "imagen_file_name"
    t.string   "imagen_content_type"
    t.integer  "imagen_file_size"
    t.datetime "imagen_updated_at"
    t.datetime "deleted_at"
    t.integer  "usuario_admin_id",                             null: false
  end

  create_table "cuentas_contable", force: true do |t|
    t.string   "nombre",                   limit: 50, default: "",    null: false
    t.string   "nivel",                    limit: 2,  default: "",    null: false
    t.boolean  "asentable",                           default: false, null: false
    t.string   "codigo",                   limit: 15, default: "",    null: false
    t.integer  "cuenta_contable_padre_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "custom_auto_increments", force: true do |t|
    t.string   "model_name"
    t.integer  "counter",    default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "custom_auto_increments", ["model_name"], name: "index_custom_auto_increments_on_model_name", using: :btree

  create_table "depositos", force: true do |t|
    t.string   "nombre",      limit: 50,  default: "",   null: false
    t.string   "descripcion", limit: 100, default: ""
    t.boolean  "disponible",              default: true, null: false
    t.string   "type",        limit: 25,  default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "depositos_stock", force: true do |t|
    t.integer  "deposito_id",                              null: false
    t.integer  "mercaderia_id",                            null: false
    t.integer  "existencia",                default: 0,    null: false
    t.integer  "existencia_min",            default: 0,    null: false
    t.integer  "existencia_max",            default: 0,    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "pedido_generado", limit: 2, default: "No"
  end

  create_table "ejercicios_contable", force: true do |t|
    t.datetime "fecha_inicio",                          null: false
    t.datetime "fecha_fin"
    t.string   "year",         limit: 4, default: "",   null: false
    t.boolean  "abierto",                default: true, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "estados", force: true do |t|
    t.string   "nombre",      limit: 50, default: "", null: false
    t.string   "abreviatura", limit: 5,  default: ""
    t.integer  "pais_id",                             null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "estados", ["nombre"], name: "index_estados_on_nombre", unique: true, using: :btree

  create_table "facturas_compra", force: true do |t|
    t.string   "numero",            limit: 15, default: "",  null: false
    t.string   "estado",            limit: 15, default: "",  null: false
    t.datetime "fecha",                                      null: false
    t.decimal  "total_factura",                default: 0.0, null: false
    t.decimal  "total_iva",                    default: 0.0, null: false
    t.integer  "orden_compra_id",                            null: false
    t.integer  "proveedor_id",                               null: false
    t.integer  "condicion_pago_id",                          null: false
    t.integer  "plazo_pago_id"
    t.integer  "user_id",                                    null: false
    t.integer  "deposito_id",                                null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "facturas_compra_detalle", force: true do |t|
    t.integer  "factura_compra_id",                               null: false
    t.integer  "componente_id",                                   null: false
    t.integer  "cantidad",                          default: 0,   null: false
    t.decimal  "costo_unitario",                    default: 0.0, null: false
    t.string   "iva_valor",               limit: 2,               null: false
    t.integer  "orden_compra_detalle_id",                         null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.integer  "cantidad_credito",                  default: 0,   null: false
  end

  create_table "interfaces", force: true do |t|
    t.string   "nombre",     limit: 50, default: "", null: false
    t.string   "seccion",    limit: 50, default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ivas", force: true do |t|
    t.string   "valor",       limit: 2,   default: "", null: false
    t.string   "descripcion", limit: 100, default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "marcas", force: true do |t|
    t.string   "nombre",     limit: 50, default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "mercaderias", force: true do |t|
    t.string   "nombre",                  limit: 50,  default: "", null: false
    t.string   "codigo",                  limit: 15,  default: ""
    t.string   "descripcion",             limit: 100, default: ""
    t.string   "type",                    limit: 10,  default: ""
    t.decimal  "costo",                                            null: false
    t.integer  "marca_id"
    t.integer  "iva_id",                                           null: false
    t.integer  "componente_categoria_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "existencia_total",                    default: 0,  null: false
    t.datetime "deleted_at"
  end

  add_index "mercaderias", ["codigo"], name: "index_mercaderias_on_codigo", unique: true, using: :btree

  create_table "notas_credito_compra", force: true do |t|
    t.string   "numero",            limit: 15, default: "",  null: false
    t.datetime "fecha",                                      null: false
    t.decimal  "total",                        default: 0.0, null: false
    t.integer  "factura_compra_id",                          null: false
    t.integer  "proveedor_id",                               null: false
    t.integer  "user_id",                                    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "notas_credito_compra_detalle", force: true do |t|
    t.integer  "nota_credito_compra_id",                  null: false
    t.integer  "componente_id",                           null: false
    t.integer  "cantidad",                  default: 0,   null: false
    t.decimal  "costo_unitario",            default: 0.0, null: false
    t.integer  "factura_compra_detalle_id",               null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "notas_debito_compra", force: true do |t|
    t.string   "numero",       limit: 15,  default: "",  null: false
    t.string   "estado",       limit: 15,  default: ""
    t.string   "motivo",       limit: 100, default: "",  null: false
    t.datetime "fecha",                                  null: false
    t.decimal  "total",                    default: 0.0, null: false
    t.integer  "proveedor_id",                           null: false
    t.integer  "user_id",                                null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "ordenes_compra", force: true do |t|
    t.string   "numero",               limit: 15, default: "",  null: false
    t.string   "estado",               limit: 15, default: "",  null: false
    t.datetime "fecha_generado",                                null: false
    t.datetime "fecha_procesado"
    t.decimal  "total_requerido",                 default: 0.0
    t.decimal  "total_recibido",                  default: 0.0
    t.integer  "user_id",                                       null: false
    t.integer  "proveedor_id",                                  null: false
    t.integer  "pedido_cotizacion_id",                          null: false
    t.integer  "pedido_compra_id",                              null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "ordenes_compra", ["numero"], name: "index_ordenes_compra_on_numero", unique: true, using: :btree

  create_table "ordenes_compra_detalle", force: true do |t|
    t.integer  "orden_compra_id",                  null: false
    t.integer  "componente_id",                    null: false
    t.decimal  "costo_unitario",     default: 0.0, null: false
    t.integer  "cantidad_requerida", default: 0,   null: false
    t.integer  "cantidad_recibida",  default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "ordenes_devolucion", force: true do |t|
    t.string   "numero",          limit: 15,  default: "",  null: false
    t.string   "numero_factura",  limit: 15,  default: "",  null: false
    t.decimal  "total_orden",                 default: 0.0, null: false
    t.datetime "fecha_generado",                            null: false
    t.string   "motivo",          limit: 100, default: ""
    t.integer  "orden_compra_id",                           null: false
    t.integer  "proveedor_id",                              null: false
    t.integer  "user_id",                                   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "ordenes_devolucion", ["numero"], name: "index_ordenes_devolucion_on_numero", unique: true, using: :btree

  create_table "ordenes_devolucion_detalle", force: true do |t|
    t.integer  "orden_devolucion_id",                               null: false
    t.integer  "componente_id",                                     null: false
    t.integer  "cantidad_devuelta",                   default: 0,   null: false
    t.decimal  "costo_unitario",                      default: 0.0
    t.string   "motivo",                  limit: 100, default: ""
    t.integer  "orden_compra_detalle_id",                           null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "paises", force: true do |t|
    t.string   "nombre",      limit: 50, default: "", null: false
    t.string   "abreviatura", limit: 5,  default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "paises", ["nombre"], name: "index_paises_on_nombre", unique: true, using: :btree

  create_table "pedidos_compra", force: true do |t|
    t.string   "numero",          limit: 15, default: "",  null: false
    t.string   "estado",          limit: 15, default: "",  null: false
    t.datetime "fecha_generado"
    t.datetime "fecha_procesado"
    t.datetime "fecha_ordenado"
    t.decimal  "total_estimado",             default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.integer  "deposito_id",                              null: false
  end

  add_index "pedidos_compra", ["numero"], name: "index_pedidos_compra_on_numero", unique: true, using: :btree

  create_table "pedidos_compra_detalle", force: true do |t|
    t.integer  "pedido_compra_id",             null: false
    t.integer  "componente_id",                null: false
    t.integer  "cantidad",         default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "pedidos_cotizacion", force: true do |t|
    t.string   "numero",           limit: 15, default: "",  null: false
    t.string   "estado",           limit: 15, default: "",  null: false
    t.datetime "fecha_generado",                            null: false
    t.datetime "fecha_cotizado"
    t.datetime "fecha_procesado"
    t.integer  "user_id",                                   null: false
    t.decimal  "total_requerido",             default: 0.0
    t.decimal  "total_cotizado",              default: 0.0
    t.integer  "pedido_compra_id",                          null: false
    t.integer  "proveedor_id",                              null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "pedidos_cotizacion", ["numero"], name: "index_pedidos_cotizacion_on_numero", unique: true, using: :btree

  create_table "pedidos_cotizacion_detalle", force: true do |t|
    t.integer  "pedido_cotizacion_id",                   null: false
    t.integer  "componente_id",                          null: false
    t.integer  "cantidad_requerida",       default: 0,   null: false
    t.integer  "cantidad_cotizada",        default: 0
    t.decimal  "costo_unitario",           default: 0.0
    t.integer  "pedido_compra_detalle_id",               null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "personas", force: true do |t|
    t.string   "nombre",                 limit: 50,  default: "", null: false
    t.string   "apellido",               limit: 50,  default: ""
    t.string   "ruc",                    limit: 20,  default: ""
    t.string   "documento_id_num",       limit: 10,  default: ""
    t.string   "direccion",              limit: 100, default: ""
    t.string   "email",                  limit: 150, default: ""
    t.string   "edad",                   limit: 3,   default: ""
    t.string   "sexo",                   limit: 9,   default: ""
    t.datetime "fecha_nacimiento"
    t.integer  "documento_identidad_id"
    t.integer  "ciudad_id"
    t.string   "type",                   limit: 9,   default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "plazos_pago", force: true do |t|
    t.string   "nombre",      limit: 50,  default: "", null: false
    t.string   "cuotas",      limit: 3,   default: "", null: false
    t.string   "descripcion", limit: 100, default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "plazos_pago_detalle", force: true do |t|
    t.integer  "plazo_pago_id",                        null: false
    t.string   "cant_dias",     limit: 3, default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "roles_interfaces", id: false, force: true do |t|
    t.integer  "role_id",     null: false
    t.integer  "interfaz_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "telefonos", force: true do |t|
    t.string  "numero",     limit: 50, default: "", null: false
    t.integer "persona_id",                         null: false
  end

  add_index "telefonos", ["numero"], name: "index_telefonos_on_numero", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                             default: "", null: false
    t.string   "encrypted_password",                default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                     default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "username",               limit: 50, default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "empleado_id"
    t.datetime "deleted_at"
  end

  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  create_table "users_roles", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

  create_table "versions", force: true do |t|
    t.string   "item_type",     null: false
    t.integer  "item_id",       null: false
    t.string   "event",         null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
    t.string   "type_subclase"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

  add_foreign_key "asientos_contable", "ejercicios_contable", :name => "asientos_contable_ejercicio_contable_id_fk", :dependent => :restrict

  add_foreign_key "asientos_contable_detalle", "asientos_contable", :name => "asientos_contable_detalle_asiento_contable_id_fk", :dependent => :delete
  add_foreign_key "asientos_contable_detalle", "cuentas_contable", :name => "asientos_contable_detalle_cuenta_contable_id_fk", :dependent => :restrict

  add_foreign_key "asientos_modelo_detalle", "asientos_modelo", :name => "asientos_modelo_detalle_asiento_modelo_id_fk", :dependent => :delete
  add_foreign_key "asientos_modelo_detalle", "cuentas_contable", :name => "asientos_modelo_detalle_cuenta_contable_id_fk", :dependent => :restrict

  add_foreign_key "ciudades", "estados", :name => "ciudades_estado_id_fk", :dependent => :delete

  add_foreign_key "compras_cuenta_corriente", "personas", :name => "compras_cuenta_corriente_proveedor_id_fk", :column => "proveedor_id", :dependent => :restrict

  add_foreign_key "compras_cuenta_corriente_cuota", "compras_cuenta_corriente_factura", :name => "c_cta_cte_factura_cuota_fk", :dependent => :delete

  add_foreign_key "compras_cuenta_corriente_factura", "compras_cuenta_corriente", :name => "compras_cuenta_corriente_factura_compra_cuenta_corriente_id_fk", :dependent => :delete
  add_foreign_key "compras_cuenta_corriente_factura", "facturas_compra", :name => "compras_cuenta_corriente_factura_factura_compra_id_fk", :dependent => :restrict

  add_foreign_key "cuentas_contable", "cuentas_contable", :name => "cuentas_contable_cuenta_contable_padre_id_fk", :column => "cuenta_contable_padre_id", :dependent => :restrict

  add_foreign_key "depositos_stock", "depositos", :name => "depositos_stock_deposito_id_fk", :dependent => :delete
  add_foreign_key "depositos_stock", "mercaderias", :name => "depositos_stock_mercaderia_id_fk", :dependent => :restrict

  add_foreign_key "estados", "paises", :name => "estados_pais_id_fk", :dependent => :delete

  add_foreign_key "facturas_compra", "condiciones_pago", :name => "facturas_compra_condicion_pago_id_fk", :dependent => :restrict
  add_foreign_key "facturas_compra", "depositos", :name => "facturas_compra_deposito_id_fk", :dependent => :restrict
  add_foreign_key "facturas_compra", "ordenes_compra", :name => "facturas_compra_orden_compra_id_fk", :dependent => :restrict
  add_foreign_key "facturas_compra", "personas", :name => "facturas_compra_proveedor_id_fk", :column => "proveedor_id", :dependent => :restrict
  add_foreign_key "facturas_compra", "plazos_pago", :name => "facturas_compra_plazo_pago_id_fk", :dependent => :restrict
  add_foreign_key "facturas_compra", "users", :name => "facturas_compra_user_id_fk", :dependent => :restrict

  add_foreign_key "facturas_compra_detalle", "facturas_compra", :name => "facturas_compra_detalle_factura_compra_id_fk", :dependent => :delete
  add_foreign_key "facturas_compra_detalle", "mercaderias", :name => "facturas_compra_detalle_componente_id_fk", :column => "componente_id", :dependent => :restrict
  add_foreign_key "facturas_compra_detalle", "ordenes_compra_detalle", :name => "facturas_compra_detalle_orden_compra_detalle_id_fk", :dependent => :restrict

  add_foreign_key "mercaderias", "componentes_categoria", :name => "mercaderias_componente_categoria_id_fk", :dependent => :restrict
  add_foreign_key "mercaderias", "ivas", :name => "mercaderias_iva_id_fk", :dependent => :restrict
  add_foreign_key "mercaderias", "marcas", :name => "mercaderias_marca_id_fk", :dependent => :restrict

  add_foreign_key "notas_credito_compra", "facturas_compra", :name => "notas_credito_compra_factura_compra_id_fk", :dependent => :restrict
  add_foreign_key "notas_credito_compra", "personas", :name => "notas_credito_compra_proveedor_id_fk", :column => "proveedor_id", :dependent => :restrict
  add_foreign_key "notas_credito_compra", "users", :name => "notas_credito_compra_user_id_fk", :dependent => :restrict

  add_foreign_key "notas_credito_compra_detalle", "facturas_compra_detalle", :name => "notas_credito_compra_detalle_factura_compra_detalle_id_fk", :dependent => :restrict
  add_foreign_key "notas_credito_compra_detalle", "mercaderias", :name => "notas_credito_compra_detalle_componente_id_fk", :column => "componente_id", :dependent => :restrict
  add_foreign_key "notas_credito_compra_detalle", "notas_credito_compra", :name => "notas_credito_compra_detalle_nota_credito_compra_id_fk", :dependent => :delete

  add_foreign_key "notas_debito_compra", "personas", :name => "notas_debito_compra_proveedor_id_fk", :column => "proveedor_id", :dependent => :restrict
  add_foreign_key "notas_debito_compra", "users", :name => "notas_debito_compra_user_id_fk", :dependent => :restrict

  add_foreign_key "ordenes_compra", "pedidos_compra", :name => "ordenes_compra_pedido_compra_id_fk", :dependent => :restrict
  add_foreign_key "ordenes_compra", "pedidos_cotizacion", :name => "ordenes_compra_pedido_cotizacion_id_fk", :dependent => :restrict
  add_foreign_key "ordenes_compra", "personas", :name => "orden_compra_proveedor_foreign_key", :column => "proveedor_id", :dependent => :restrict
  add_foreign_key "ordenes_compra", "users", :name => "orden_compra_usuario_foreign_key", :dependent => :restrict

  add_foreign_key "ordenes_compra_detalle", "mercaderias", :name => "orden_compra_detalle_componente_foreign_key", :column => "componente_id", :dependent => :restrict
  add_foreign_key "ordenes_compra_detalle", "ordenes_compra", :name => "orden_compra_detalle_orden_foreign_key", :dependent => :delete

  add_foreign_key "ordenes_devolucion", "ordenes_compra", :name => "ordenes_devolucion_orden_compra_id_fk", :dependent => :delete
  add_foreign_key "ordenes_devolucion", "personas", :name => "ordenes_devolucion_proveedor_id_fk", :column => "proveedor_id", :dependent => :restrict
  add_foreign_key "ordenes_devolucion", "users", :name => "ordenes_devolucion_user_id_fk", :dependent => :restrict

  add_foreign_key "ordenes_devolucion_detalle", "mercaderias", :name => "ordenes_devolucion_detalle_componente_id_fk", :column => "componente_id", :dependent => :restrict
  add_foreign_key "ordenes_devolucion_detalle", "ordenes_compra_detalle", :name => "ordenes_devolucion_detalle_orden_compra_detalle_id_fk", :dependent => :restrict
  add_foreign_key "ordenes_devolucion_detalle", "ordenes_devolucion", :name => "ordenes_devolucion_detalle_orden_devolucion_id_fk", :dependent => :delete

  add_foreign_key "pedidos_compra", "depositos", :name => "pedidos_compra_deposito_id_fk", :dependent => :restrict

  add_foreign_key "pedidos_compra_detalle", "mercaderias", :name => "pedido_compra_detalle_componente_foreign_key", :column => "componente_id", :dependent => :restrict
  add_foreign_key "pedidos_compra_detalle", "pedidos_compra", :name => "pedido_compra_detalle_pedido_foreign_key", :dependent => :delete

  add_foreign_key "pedidos_cotizacion", "pedidos_compra", :name => "pedidos_cotizacion_pedido_compra_id_fk", :dependent => :restrict
  add_foreign_key "pedidos_cotizacion", "personas", :name => "pedidos_cotizacion_proveedor_id_fk", :column => "proveedor_id", :dependent => :restrict
  add_foreign_key "pedidos_cotizacion", "users", :name => "pedidos_cotizacion_user_id_fk", :dependent => :restrict

  add_foreign_key "pedidos_cotizacion_detalle", "mercaderias", :name => "pedidos_cotizacion_detalle_componente_id_fk", :column => "componente_id", :dependent => :restrict
  add_foreign_key "pedidos_cotizacion_detalle", "pedidos_compra_detalle", :name => "pedidos_cotizacion_detalle_pedido_compra_detalle_id_fk", :dependent => :restrict
  add_foreign_key "pedidos_cotizacion_detalle", "pedidos_cotizacion", :name => "pedidos_cotizacion_detalle_pedido_cotizacion_id_fk", :dependent => :delete

  add_foreign_key "personas", "ciudades", :name => "personas_ciudad_id_fk", :dependent => :restrict

  add_foreign_key "plazos_pago_detalle", "plazos_pago", :name => "plazos_pago_detalle_plazo_pago_id_fk", :dependent => :delete

  add_foreign_key "roles_interfaces", "interfaces", :name => "roles_interfaces_interfaz_id_fk", :dependent => :delete
  add_foreign_key "roles_interfaces", "roles", :name => "roles_interfaces_role_id_fk", :dependent => :delete

  add_foreign_key "telefonos", "personas", :name => "telefonos_persona_id_fk", :dependent => :delete

end
