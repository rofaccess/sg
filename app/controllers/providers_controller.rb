class ProvidersController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_provider, only: [:show, :edit, :update, :destroy]
  respond_to :html, :js

  def index
    @providers = Provider.all
  end

  def show
  end

  def new
    @provider = Provider.new
  end

  def create
    @provider = Provider.new(provider_params)

    if @provider.save
      redirect_to providers_path, notice: t('messages.provider_saved')
    else
      redirect_to providers_path, alert: t('messages.provider_not_saved')
    end

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

  def set_provider
    @provider = Provider.find(params[:id])
  end

  def provider_params
      params.require(:provider).permit(:name, :ruc, :address, :phone, :email)
  end
end
