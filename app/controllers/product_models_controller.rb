class ProductModelsController < ApplicationController

  def index
    @product_models = ProductModel.all
  end

  def new 
    @product_model = ProductModel.new    
    @suppliers = Supplier.all
  end

  def create
    @product_model = ProductModel.new(product_models_params) 
    @product_model.save
    redirect_to @product_model, notice: 'Modelo de produto cadastrado com sucesso'
  end

  def show
    @product_model = ProductModel.find(params[:id]) 
  end

  private 
    def product_models_params
      params.require(:product_model).permit(:name, :weight, :height, :width, :depth, :sku, :supplier_id)
    end
end
