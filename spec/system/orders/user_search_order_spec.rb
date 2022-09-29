require 'rails_helper'

describe "Usuário busca por um pedido" do

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
    warehouse = create(:warehouse)
    supplier = create(:supplier)
    order = create(:order, user: subject, warehouse: warehouse, supplier: supplier)
  
    #act     
    login_as(subject)
    visit root_path
    fill_in "Buscar Pedido", with: order.code
    click_on 'Buscar'
    #assert
    expect(page).to have_content "Resultados da Busca por: #{order.code}"
    expect(page).to have_content '1 Pedido encontrado'
    expect(page).to have_content "Código: #{order.code}"  
    expect(page).to have_content "Galpão Destino: GRU - #{warehouse.name}"  
    expect(page).to have_content "Fornecedor: #{supplier.corporate_name}"  

  end 

  it'e encontra múltiplos pedidos' do
    first_warehouse = Warehouse.create(name:'Aeroporto SP', code:'GRU' , city: 'Guarulhos', area: 100_000,
                                      address: 'Avenida do Aeroporto, 100', cep: '15000-000',
                                      description: 'Galpão destinado para cargas internacionais')
    second_warehouse = Warehouse.create!(name:'Aeroporto Rio', code: 'SDU', area:'10000', cep: '56000-000', 
                                          address:'Av. do aeroporto, 1000', city:'Rio de Janeiro', 
                                        description: 'Galpão no Rio')
    first_supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: CNPJ.generate,
                                      full_address: 'Av das palmas, 100', city:'Bauru', state: 'SP', email: 'contato@gmail.com')
    luiza_user = User.create!(name: 'Luiza', email: 'luiza@teste.com', password: 'password')

    allow(SecureRandom).to receive(:alphanumeric).with(Order::CODE_LENGTH).and_return('GRU1234567')
    first_order = Order.create(estimated_delivery_date: 2.day.from_now, user: luiza_user, warehouse: first_warehouse, supplier: first_supplier)

    allow(SecureRandom).to receive(:alphanumeric).with(Order::CODE_LENGTH).and_return('GRU1234567')
    second_order = Order.create(estimated_delivery_date: 3.day.from_now, user: luiza_user, warehouse: first_warehouse, supplier: first_supplier)
    
    allow(SecureRandom).to receive(:alphanumeric).with(Order::CODE_LENGTH).and_return('SDU1234567')
    third_order = Order.create(estimated_delivery_date: 4.day.from_now, user: luiza_user, warehouse: second_warehouse, supplier: first_supplier)
    
    login_as(subject)
    visit root_path
    fill_in "Buscar Pedido",	with: 'GRU'
    click_on 'Buscar'
    #assert
    expect(page).to have_content '2 Pedidos encontrados'
    expect(page).to have_content 'GRU1234567'
    expect(page).to have_content 'Galpão Destino: GRU - Aeroporto SP'
    expect(page).not_to have_content 'SDU1234567'
    expect(page).not_to have_content 'Galpão Destino: SDU - Aeroporto Rio'
  end
  
end