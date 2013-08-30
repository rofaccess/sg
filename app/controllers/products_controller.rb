class ProductsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_product, only: [:show, :edit, :update, :destroy] 
  respond_to :html, :js
  def index
  	@search = Product.search(params[:q])
    @products = @search.result
  end
  def show
  end
  def new
  	@product = Product.new
  end
  def edit
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to products_path, notice: t('messages.provider_saved')
    else
      redirect_to products_path, alert: t('messages.provider_not_saved')
    end

  end

  def update
    if @product.update(product_params)
      redirect_to products_path, notice: t('messages.provider_saved')
    else
      redirect_to products_path, alert: t('messages.provider_not_saved')
    end
  end
  
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url }
      format.json { head :no_content }
    end
  end

  def set_product
    @product = Product.find(params[:id])
  end  

  def product_params
      params.require(:product).permit(:name, :mark, :unit_price, :provider_id)
  end
end
