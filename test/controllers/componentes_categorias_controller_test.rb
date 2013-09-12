require 'test_helper'

class ComponentesCategoriasControllerTest < ActionController::TestCase
  setup do
    @componente_categoria = componentes_categorias(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:componentes_categorias)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create componente_categoria" do
    assert_difference('ComponenteCategoria.count') do
      post :create, componente_categoria: { nombre: @componente_categoria.nombre }
    end

    assert_redirected_to componente_categoria_path(assigns(:componente_categoria))
  end

  test "should show componente_categoria" do
    get :show, id: @componente_categoria
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @componente_categoria
    assert_response :success
  end

  test "should update componente_categoria" do
    patch :update, id: @componente_categoria, componente_categoria: { nombre: @componente_categoria.nombre }
    assert_redirected_to componente_categoria_path(assigns(:componente_categoria))
  end

  test "should destroy componente_categoria" do
    assert_difference('ComponenteCategoria.count', -1) do
      delete :destroy, id: @componente_categoria
    end

    assert_redirected_to componentes_categorias_path
  end
end
