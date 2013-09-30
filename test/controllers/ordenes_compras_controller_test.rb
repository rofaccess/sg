require 'test_helper'

class OrdenesComprasControllerTest < ActionController::TestCase
  setup do
    @orden_compra = ordenes_compras(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ordenes_compras)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create orden_compra" do
    assert_difference('OrdenCompra.count') do
      post :create, orden_compra: { costo_total: @orden_compra.costo_total, estado: @orden_compra.estado, fecha: @orden_compra.fecha, numero: @orden_compra.numero, pedido_cotizacion_id: @orden_compra.pedido_cotizacion_id, proveedor_id: @orden_compra.proveedor_id, user_id: @orden_compra.user_id }
    end

    assert_redirected_to orden_compra_path(assigns(:orden_compra))
  end

  test "should show orden_compra" do
    get :show, id: @orden_compra
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @orden_compra
    assert_response :success
  end

  test "should update orden_compra" do
    patch :update, id: @orden_compra, orden_compra: { costo_total: @orden_compra.costo_total, estado: @orden_compra.estado, fecha: @orden_compra.fecha, numero: @orden_compra.numero, pedido_cotizacion_id: @orden_compra.pedido_cotizacion_id, proveedor_id: @orden_compra.proveedor_id, user_id: @orden_compra.user_id }
    assert_redirected_to orden_compra_path(assigns(:orden_compra))
  end

  test "should destroy orden_compra" do
    assert_difference('OrdenCompra.count', -1) do
      delete :destroy, id: @orden_compra
    end

    assert_redirected_to ordenes_compras_path
  end
end
