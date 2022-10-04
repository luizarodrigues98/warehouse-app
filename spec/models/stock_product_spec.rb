require 'rails_helper'

RSpec.describe StockProduct, type: :model do
  describe "gera um número de série" do
    before(:each) do
      @user = create(:user) 
      @warehouse = create(:warehouse)
      @supplier = create(:supplier)
      @order = create(:order, estimated_delivery_date: 1.week.from_now, status: :delivered,
                        user: @user, warehouse: @warehouse, supplier: @supplier)
      @pm = ProductModel.create!(name:'TV 32 polegadas', weight: 80, width: 70, height: 45, depth: 10,sku: 'TV32-SAMSU-XPTO90595', supplier: @supplier)  
    end 
          

    it 'ao criar um StockProduct' do    
      stock_product = StockProduct.create!(order: @order, warehouse:@warehouse, product_model: @pm)
      expect(stock_product.serial_number.length).to eq 20 
    end

    it 'e não é modificado' do
      warehouse = Warehouse.create!(name:'RJ', code: 'Rio', address: 'Endereço',
                                    cep:'25000-000', city: 'Rio', area: 1000, 
                                  description: 'Alguma descrição')
      stock_product = StockProduct.create!(order: @order, warehouse: @warehouse, product_model: @pm)
      original_serial_number = stock_product.serial_number
      stock_product.update(warehouse: warehouse)
      expect(stock_product.serial_number).to eq original_serial_number
    end

  end
  describe '#available?' do
    before(:each) do
      @user = create(:user) 
      @warehouse = create(:warehouse)
      @supplier = create(:supplier)
      @order = create(:order, estimated_delivery_date: 1.week.from_now, status: :delivered,
                        user: @user, warehouse: @warehouse, supplier: @supplier)
      @pm = ProductModel.create!(name:'TV 32 polegadas', weight: 80, width: 70, height: 45, depth: 10,sku: 'TV32-SAMSU-XPTO90595', supplier: @supplier)  
    end 
          
    it 'true se não tiver destino' do
      stock_product = StockProduct.create!(order: @order, warehouse:@warehouse, product_model: @pm)
      expect(stock_product.available?).to eq true  
    end
    
    it 'false se não tiver destino' do
      stock_product = StockProduct.create!(order: @order, warehouse:@warehouse, product_model: @pm)
      stock_product.create_stock_product_destination!(recipient: 'João', address: 'R. do joão')

      expect(stock_product.available?).to eq false 
    end
  end
end
