class AddDeletedAtToPlazosPagosTable < ActiveRecord::Migration
  def change
    add_column :plazos_pago, :deleted_at, :datetime
    add_column :ivas, :deleted_at, :datetime
  end
end
