class ProductModelsController < ApplicationController
  before_action :set_product_models, only: [:show, :edit, :update]

  before_action :authenticate_user!

  def index
    @product_models = ProductModel.all
  end

  def new 
    @product_model = ProductModel.new    
    @suppliers = Supplier.all
  end

  def create
    @suppliers = Supplier.all
    @product_model = ProductModel.new(product_models_params) 
    if @product_model.save
    redirect_to @product_model, notice: 'Modelo de produto cadastrado com sucesso'
    else
      flash.now[:notice] = 'Não foi possivel cadastrar o modelo de produto'
      render 'new'
    end
  end

  def show
  end

  def edit
    @suppliers = Supplier.all

  end

  def update
    @suppliers = Supplier.all
    if @product_model.update(product_models_params)
      redirect_to product_model_path(@product_model.id), notice: 'Modelo de produto atualizado com sucesso'
    else
      flash.now[:notice] = "Não foi possivel atualizar o modelo de produto"
      render 'edit'   
    end
  end

  private 

    def set_product_models
      @product_model = ProductModel.find(params[:id]) 

    end
    def product_models_params
      params.require(:product_model).permit(:name, :weight, :height, :width, :depth, :sku, :supplier_id)
    end
end
