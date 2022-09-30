require 'rails_helper'

describe "Usuário informa novo status de pedido" do

  subject { create(:user) } 

  before(:each) do
    @warehouse = create(:warehouse)
    @supplier = create(:supplier)
    @order = create(:order, user: subject, warehouse: @warehouse, supplier: @supplier, status: :pending)
  end

  it 'e pedido foi entregue' do
    
    login_as(subject)
    visit root_path
    click_on 'Meus Pedidos'
    click_on @order.code
    click_on 'Marcar como Entregue'
  
    expect(current_path).to eq order_path(@order.id)
    expect(page).to have_content('Situação do Pedido: Entregue') 
    expect(page).not_to have_button 'Marcar como Cancelado' 
    expect(page).not_to have_button 'Marcar como Entregue' 
  end

  it 'e pedido foi cancelado' do
    
    login_as(subject)
    visit root_path
    click_on 'Meus Pedidos'
    click_on @order.code
    click_on 'Marcar como Cancelado'
    expect(current_path).to eq order_path(@order.id)
    expect(page).to have_content('Situação do Pedido: Cancelado') 

  end
end