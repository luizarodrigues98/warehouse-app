require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '#valid?' do
    before(:each) do
      @user = create(:user) 
      @warehouse = create(:warehouse)
      @supplier = create(:supplier)
    end
    it 'deve ter um código' do
      order = build(:order, user: @user, warehouse: @warehouse, supplier: @supplier)
      result = order.valid?
      expect(result).to be true 
    end

    it 'data estimada de entrega deve ser obrigatório' do
      order = build(:order, estimated_delivery_date: nil, user: @user, warehouse: @warehouse, supplier: @supplier)
      order.valid?
      result = order.errors.include?(:estimated_delivery_date)
      expect(result).to be true
    end
    it 'data estimada de entrega não deve ser passsada' do
      order = build(:order, estimated_delivery_date: 1.day.ago, user: @user, warehouse: @warehouse, supplier: @supplier)
      order.valid?
      result = order.errors.include?(:estimated_delivery_date)
      expect(result).to be true
      expect(order.errors[:estimated_delivery_date]).to include("deve ser maior que a data atual.")  
    end
    
    it 'data estimada de entrega não deve ser igual a hoje' do
      order = build(:order, estimated_delivery_date: Date.today, user: @user, warehouse: @warehouse, supplier: @supplier)
      order.valid?
      result = order.errors.include?(:estimated_delivery_date)
      expect(result).to be true
      expect(order.errors[:estimated_delivery_date]).to include("deve ser maior que a data atual.")  
    end
        
    it 'data estimada de entrega deve ser igual ou maior que amanha' do
      order = build(:order, estimated_delivery_date:  1.day.from_now, user: @user, warehouse: @warehouse, supplier: @supplier)
      order.valid?
      result = order.errors.include?(:estimated_delivery_date)
      expect(result).to be false
    end
  end
  
  describe "Gera um código aleatório" do
    before(:each) do
      @user = create(:user) 
      @warehouse = create(:warehouse)
      @supplier = create(:supplier)
      @order = create(:order, estimated_delivery_date: 1.week.from_now, 
        user: @user, warehouse: @warehouse, supplier: @supplier)
    end
    
    
    it 'ao criar um novo pedido' do

      result = @order.code
      expect(result).not_to be_empty  
      expect(result.length).to eq 10 
    end
    
    it 'e o código é único' do
      second_order = Order.new(user: @user, supplier: @supplier, warehouse: @warehouse, estimated_delivery_date: (Date.today + 7.days))
      second_order.save!
      result = @order.code
      expect(second_order.code).not_to eq result  
    end

    it 'e não deve ser modificado' do
      original_code = @order.code
      @order.update!(estimated_delivery_date: 1.month.from_now,)
      expect(@order.code).to eq(original_code)
    end
  end
end
