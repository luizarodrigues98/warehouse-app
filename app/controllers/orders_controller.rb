class OrdersController < ApplicationController
  before_action :authenticate_user!
  
  def index
    
  end
  def new
    @order = Order.new
    @warehouses = Warehouse.all
    @suppliers = Supplier.all
  end
  def create
    @suppliers = Supplier.all
    @warehouses = Warehouse.all
    @order = Order.new(order_params) 
    @order.user = current_user
    if @order.save
      redirect_to order_path(@order), notice: 'Pedido registrado com sucesso.'
    else
      flash.now[:notice] = 'Não foi possivel cadastrar o modelo de produto'
      render 'new'
    end
  end

  def show
    @order = Order.find(params[:id])
    @user = @order.user
  end

  private
  def order_params
    params.require(:order).permit(:warehouse_id, :supplier_id, :estimated_delivery_date)
  end
end