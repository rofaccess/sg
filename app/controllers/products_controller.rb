class ProductsController < ApplicationController
  def index
  	@products = Product.all
  end

  def new
  	@product = Product.new
  end
  def edit
  end

  def create
  	@product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'El Producto fue Creado Satisfactoriamente.' }
       # format.json { render action: 'show', status: :created, location: @product }
      else
        format.html { render action: 'new' }
        #format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'El Producto fue Actualizado Satisfactoriamente.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url }
      format.json { head :no_content }
    end
  end
  def product_params
      params.require(:product).permit(:name, :mark, :unit_price)
  end
end
