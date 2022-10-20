class Api::V1::WarehousesController < ActionController::API
  rescue_from ActiveRecord::ActiveRecordError, with: :return_500
  rescue_from ActiveRecord::RecordNotFound, with: :return_404
  
  def show
    warehouse = Warehouse.find(params[:id])
    render status: 200, json: warehouse.as_json(except: [:created_at, :updated_at])
  end

  def index
    warehouses = Warehouse.all.order(:name)
    render json: warehouses, status: 200
  end

  def create
    warehouse = Warehouse.new(warehouse_params)
    if warehouse.save
      render status: 201, json: warehouse
    else
      render status: 412, json: { errors: warehouse.errors.full_messages }
    end
  end

  private
  def warehouse_params
    params.require(:warehouse).permit(:name, :code, :city, :address, :area, :cep, :description)
  end
  def return_500
    render status: 500
  end
  def return_404
    render status: 404
  end
end