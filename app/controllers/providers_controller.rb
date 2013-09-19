class ProvidersController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_provider, only: [:show, :edit, :update, :destroy]
  before_action :set_sidemenu, only: [:index]
  respond_to :html, :js

  def set_sidemenu
    @sidebar_layout = 'layouts/compras_sidemenu'
  end

  def index
    @search = Provider.search(params[:q])
    @provider = Provider.new
    if @search.sorts.empty?
      @providers = @search.result.order('name').page(params[:page]).per(10)
    else
      @providers = @search.result.page(params[:page]).per(10)
    end
  end

  def show
  end

  def new
    @provider = Provider.new
  end

  def create
    @provider = Provider.new(provider_params)
    params[:provider][:componente_categoria_ids].each do |v,k|
      @provider.componente_categorias << ComponenteCategoria.find(v) unless v.empty?
    end
    if @provider.save
      update_list
    else
      redirect_to providers_path, alert: t('messages.provider_not_saved')
    end

  end

  def update_list
    index
    render partial: 'update_list', format: 'js'
  end

  def edit
   # @provider = Provider.find(params[:id])
   # respond_with @provider
  end

  def update
    old_cat = @provider.componente_categoria_ids
    new_cat = params[:provider][:componente_categoria_ids]

    old_cat.each do |o|
      @provider.componente_categorias.destroy(ComponenteCategoria.find(o)) unless new_cat.include?(o)
    end

    new_cat.each do |n|
      @provider.componente_categorias << ComponenteCategoria.find(n) unless n.empty? || old_cat.include?(n)
    end

    if @provider.update(provider_params)
      update_list
    else
      redirect_to providers_path, alert: t('messages.provider_not_saved')
    end
  end

  def destroy
    #@provider = Provider.find(params[:id])

    if @provider.destroy
      redirect_to providers_path, notice: t('messages.provider_deleted')
    else
      redirect_to providers_path, alert: t('messages.provider_not_deleted')
    end
  end

  def nueva_ciudad
    @ciudad = Ciudad.new
    @paises = Pais.all
    @estados = Estado.all
  end

  def nueva_categoria
    @componente_categoria = ComponenteCategoria.new
  end

  def load_test_data
    @provider = Provider.new(  name: Faker::Company.name,
            ruc: Faker::Number.number(9),
            address: Faker::Address.street_address,
            phone: Faker::PhoneNumber.phone_number,
            email: Faker::Internet.email)
  end

  def set_provider
    @provider = Provider.find(params[:id])
  end

  def provider_params
      params.require(:provider).permit(:name, :ruc, :address, :phone, :email, :ciudad_id)
  end
end
