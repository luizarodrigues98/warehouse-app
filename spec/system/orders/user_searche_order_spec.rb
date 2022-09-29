require 'rails_helper'

describe "Usuário busca por um pedido" do
  before(:each) do
    @user = create(:user) 
    @warehouse = create(:warehouse)
    @supplier = create(:supplier)
    @order = create(:order,estimated_delivery_date: 1.day.from_now, user: @user, warehouse: @warehouse, supplier: @supplier)
  end
  subject { create(:user) } 

  it 'a partir do menu' do
    #arrange
    #act 
    visit root_path
    #assert
    within ('header nav') do 
      expect(page).not_to have_field('Buscar Pedido') 
      expect(page).not_to have_button('Buscar') 
    end
  end  
  it 'e deve estar autenticado' do
    #arrange
    #act 
    login_as(subject)
    visit root_path
    #assert
    within ('header nav') do 
      expect(page).to have_field('Buscar Pedido') 
      expect(page).to have_button('Buscar') 
    end
  end

  it 'e encontra um pedido' do
    #act     
    login_as(subject)
    visit root_path
    fill_in "Buscar Pedido",	with: @order.code
    click_on 'Buscar'
    #assert
    expect(page).to have_content "Resultados da Busca por: #{@order.code}"
    expect(page).to have_content '1 pedido encontrado'
    expect(page).to have_content "Código: #{@order.code}"  
    expect(page).to have_content "Galpão Destino: GRU - #{@warehouse.name}"  
    expect(page).to have_content "Fornecedor: #{@supplier.corporate_name}"  

  end  
end