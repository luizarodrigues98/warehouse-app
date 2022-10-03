require 'rails_helper'

describe "Usuário informa novo status de pedido" do

  subject { create(:user) } 

  before(:each) do
    @warehouse = create(:warehouse)
    @supplier = create(:supplier)
    @order = create(:order, user: subject, warehouse: @warehouse, supplier: @supplier, status: :pending)
  end

  it 'e pedido foi entregue' do
    product = ProductModel.create!(name:'Cadeira Gamer', weight: 8000, width: 70, height: 100, depth: 75,  
      sku: 'CAD-GAMER-XSPTOX9595', supplier: @supplier)
    OrderItem.create!(order: @order, product_model: product, quantity: 5 )
    
    login_as(subject)
    visit root_path
    click_on 'Meus Pedidos'
    click_on @order.code
    click_on 'Marcar como Entregue'
  
    expect(current_path).to eq order_path(@order.id)
    expect(page).to have_content('Situação do Pedido: Entregue') 
    expect(page).not_to have_button 'Marcar como Cancelado' 
    expect(page).not_to have_button 'Marcar como Entregue' 
    
    estoque = StockProduct.where(product_model:product, warehouse: @warehouse).count
    expect(estoque).to eq 5  
  end

  it 'e pedido foi cancelado' do
    product = ProductModel.create!(name:'Cadeira Gamer', weight: 8000, width: 70, height: 100, depth: 75,  
      sku: 'CAD-GAMER-XSPTOX9595', supplier: @supplier)
    OrderItem.create!(order: @order, product_model: product, quantity: 5 )
    
    login_as(subject)
    visit root_path
    click_on 'Meus Pedidos'
    click_on @order.code
    click_on 'Marcar como Cancelado'
    expect(current_path).to eq order_path(@order.id)
    expect(page).to have_content('Situação do Pedido: Cancelado') 
    expect(StockProduct.count).to eq 0 
  end
end