class OrdersController < ApplicationController
  before_action :authenticate_user!

  def new
    @order = Order.new
    @warehouses = Warehouse.all
    @suppliers = Supplier.all
  end
  
  def create
    @order = Order.new(order_params) 
    @order.user = current_user
    if @order.save
      redirect_to order_path(@order), notice: 'Pedido registrado com sucesso.'
    else
      @suppliers = Supplier.all
      @warehouses = Warehouse.all
      flash.now[:notice] = 'Não foi possível registrar o pedido'
      render 'new'
    end
  end

  def show
    @order = Order.find(params[:id])
    @user = @order.user
  end
  
  def search
    @code = params["query"]
    @orders = Order.where("code like ?", "%#{@code}%")
  end

  private
  def order_params
    params.require(:order).permit(:warehouse_id, :supplier_id, :estimated_delivery_date)
  end
end