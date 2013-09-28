require 'test_helper'

class PedidoCotizacionsControllerTest < ActionController::TestCase
  setup do
    @pedido_cotizacion = pedido_cotizacions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pedido_cotizacions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pedido_cotizacion" do
    assert_difference('PedidoCotizacion.count') do
      post :create, pedido_cotizacion: { estado: @pedido_cotizacion.estado, fecha_cotizado: @pedido_cotizacion.fecha_cotizado, fecha_creacion: @pedido_cotizacion.fecha_creacion, numero: @pedido_cotizacion.numero, pedido_compra_id: @pedido_cotizacion.pedido_compra_id, proveedor_id: @pedido_cotizacion.proveedor_id, user_id: @pedido_cotizacion.user_id }
    end

    assert_redirected_to pedido_cotizacion_path(assigns(:pedido_cotizacion))
  end

  test "should show pedido_cotizacion" do
    get :show, id: @pedido_cotizacion
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pedido_cotizacion
    assert_response :success
  end

  test "should update pedido_cotizacion" do
    patch :update, id: @pedido_cotizacion, pedido_cotizacion: { estado: @pedido_cotizacion.estado, fecha_cotizado: @pedido_cotizacion.fecha_cotizado, fecha_creacion: @pedido_cotizacion.fecha_creacion, numero: @pedido_cotizacion.numero, pedido_compra_id: @pedido_cotizacion.pedido_compra_id, proveedor_id: @pedido_cotizacion.proveedor_id, user_id: @pedido_cotizacion.user_id }
    assert_redirected_to pedido_cotizacion_path(assigns(:pedido_cotizacion))
  end

  test "should destroy pedido_cotizacion" do
    assert_difference('PedidoCotizacion.count', -1) do
      delete :destroy, id: @pedido_cotizacion
    end

    assert_redirected_to pedido_cotizacions_path
  end
end
