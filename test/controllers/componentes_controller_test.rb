require 'test_helper'

class ComponentesControllerTest < ActionController::TestCase
  setup do
    @componente = componentes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:componentes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create componente" do
    assert_difference('Componente.count') do
      post :create, componente: { componente_categoria_id: @componente.componente_categoria_id, costo: @componente.costo, marca_id: @componente.marca_id, nombre: @componente.nombre, numero_serie: @componente.numero_serie }
    end

    assert_redirected_to componente_path(assigns(:componente))
  end

  test "should show componente" do
    get :show, id: @componente
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @componente
    assert_response :success
  end

  test "should update componente" do
    patch :update, id: @componente, componente: { componente_categoria_id: @componente.componente_categoria_id, costo: @componente.costo, marca_id: @componente.marca_id, nombre: @componente.nombre, numero_serie: @componente.numero_serie }
    assert_redirected_to componente_path(assigns(:componente))
  end

  test "should destroy componente" do
    assert_difference('Componente.count', -1) do
      delete :destroy, id: @componente
    end

    assert_redirected_to componentes_path
  end
end
