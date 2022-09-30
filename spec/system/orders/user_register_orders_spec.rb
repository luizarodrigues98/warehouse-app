require 'rails_helper'

describe "Usuário cadastra um pedido" do
  before(:each) do
    @user = create(:user) 
    @warehouse = create(:warehouse)
    @supplier = create(:supplier)
    @order = create(:order, user: @user, warehouse: @warehouse, supplier: @supplier)
  end
  subject { create(:user) } 

  it 'e deve estar autenticado' do
    visit root_path
    click_on 'Registrar Pedido'

    expect(current_path).to eq new_user_session_path
  end

  it 'com sucesso' do
    #arrange
    warehouse = Warehouse.create!(name:'Aeroporto SP', code:'GRP' , city: 'Guarulhos', area: 100_000,
                                address: 'Avenida do Aeroporto, 100', cep: '15000-000',
                                description: 'Galpão destinado para cargas internacionais')
     
    supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', 
                                registration_number: CNPJ.generate,
                                full_address: 'Av das palmas, 100', city:'Bauru', 
                                state: 'SP', email: 'contato@gmail.com')
    
    allow(SecureRandom).to receive(:alphanumeric).with(Order::CODE_LENGTH).and_return('ABC1234567')
    #act
    visit root_path
    login_as(subject)
    click_on 'Registrar Pedido'
    select 'GRP - Aeroporto SP', from: 'Galpão Destino'
    select supplier.corporate_name, from: "Fornecedor"
    fill_in "Data Prevista de Entrega",	with: "20/12/2022" 
    click_on 'Gravar'
    #assert
    expect(page).to have_content 'Pedido registrado com sucesso.'
    expect(page).to have_content "Pedido ABC1234567"
    expect(page).to have_content 'Galpão Destino: GRP - Aeroporto SP'
    expect(page).to have_content "Usuário Responsável: #{subject.name} - #{subject.email}"
    expect(page).to have_content "Fornecedor: #{supplier.full_description}"
    expect(page).to have_content "Data Prevista de Entrega: 20/12/2022"
    
    expect(page).to have_content "Situação do Pedido: Pendente"

    expect(page).not_to have_content 'Galpão Rio'
    expect(page).not_to have_content 'Samsung Eletrônicos LTDA'
  end

  it 'e não informa a data de entrega' do
    warehouse = Warehouse.create!(name:'Aeroporto SP', code:'GRP' , city: 'Guarulhos', area: 100_000,
                                  address: 'Avenida do Aeroporto, 100', cep: '15000-000',
                                  description: 'Galpão destinado para cargas internacionais')

    visit root_path
    login_as(subject)
    visit root_path
    click_on 'Registrar Pedido'
    select 'GRP - Aeroporto SP', from: 'Galpão Destino'
    select @supplier.corporate_name, from: "Fornecedor"
    fill_in "Data Prevista de Entrega",	with: nil
    click_on 'Gravar'
    expect(page).to have_content 'Não foi possível registrar o pedido'

  end

  it 'e a data de entrega deve ser maior que hoje ' do
    order = build(:order, estimated_delivery_date: 1.day.from_now, user: @user, warehouse: @warehouse, supplier: @supplier)
    order.valid?
    result = order.errors.include?(:estimated_delivery_date)
    expect(result).to be false
  end
end
