class WarehousesController < ApplicationController

  def show
    @warehouse = Warehouse.find(params[:id])
  end
  def new

  end
  def create
    @warehouse = Warehouse.new(warehouse_params)
    @warehouse.save()
    flash[:notice] = 'Galpão cadastrado com sucesso.'
    redirect_to root_path 
  end

  private
  
  def warehouse_params
    params.require(:warehouse).permit(:name, :code, :description, 
                                      :address, :city, :cep, :area)
  end
end