class DepositosMateriaPrimaController < DepositosController
  before_action :set_deposito, only: [:show, :edit, :update, :destroy, :imprimir_factura]
  respond_to :html, :js

  def update
    @dep = Deposito.new(deposito_params)

      @dep.deposito_stocks.each do |s|
        # Actualiza existencia_total de Componentes
        componente = Componente.find(s.mercaderia_id)
        existencia_total_actual = componente.existencia_total
        existencia_actual = DepositoStock.find(s.id).existencia
        existencia_nueva = s.existencia
        componente.update(existencia_total: (existencia_total_actual + (existencia_nueva - existencia_actual)))
        if existencia_nueva > existencia_actual
          componente.update(existencia_total: (existencia_total_actual + (existencia_nueva - existencia_actual)))
        else
          componente.update(existencia_total: (existencia_total_actual - (existencia_actual - existencia_nueva)))
        end
      end

    if @deposito.update(deposito_params)
      flash.notice = "Se ha actualizado el deposito #{@deposito.nombre}."
      update_list
    else
      flash.alert = "No se ha podido actualizar el deposito #{@deposito.nombre}."
    end
  end

  def set_deposito
    @deposito = DepositoMateriaPrima.find(params[:id])
  end

  def deposito_params
    params.require(:deposito_materia_prima).permit(:id,
        deposito_stocks_attributes: [:existencia, :existencia_min, :existencia_max, :id, :mercaderia_id])
  end
end
