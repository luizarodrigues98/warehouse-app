require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '#valid?' do
    before(:each) do
      @user = create(:user) 
      @warehouse = create(:warehouse)
      @supplier = create(:supplier)
    end
    it 'deve ter um código' do
      order = Order.new( estimated_delivery_date: Date.today, user: @user, warehouse: @warehouse, supplier: @supplier)
      result = order.valid?
      expect(result).to be true 
    end
  end
  
  describe "Gera um código aleatório" do
    before(:each) do
      @user = create(:user) 
      @warehouse = create(:warehouse)
      @supplier = create(:supplier)
      @order = create(:order, user: @user, warehouse: @warehouse, supplier: @supplier)
    end
    
    
    it 'ao criar um novo pedido' do

      result = @order.code
      expect(result).not_to be_empty  
      expect(result.length).to eq 10 
    end
    
    it 'e o código é único' do
      second_order = Order.new(user: @user, supplier: @supplier, warehouse: @warehouse, estimated_delivery_date: (Date.today))
      second_order.save!
      result = @order.code
      expect(second_order.code).not_to eq result  
    end
  end
end
