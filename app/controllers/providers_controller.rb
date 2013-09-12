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
      @providers = @search.result.order('name')
    else
      @providers = @search.result
    end
  end

  def show
  end

  def new
    @provider = Provider.new
  end

  def create
    @provider = Provider.new(provider_params)

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
    #@provider = Provider.find(params[:id])

    if @provider.update(provider_params)
      redirect_to providers_path, notice: t('messages.provider_saved')
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
      params.require(:provider).permit(:name, :ruc, :address, :phone, :email)
  end
end
