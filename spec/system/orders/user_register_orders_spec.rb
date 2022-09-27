require 'rails_helper'

describe "Usuário cadastra um pedido" do
  subject { create(:user) } 

  it 'com sucesso' do
    #arrange
    warehouse = Warehouse.create(name:'Aeroporto SP', code:'GRU' , city: 'Guarulhos', area: 100_000,
                                address: 'Avenida do Aeroporto, 100', cep: '15000-000',
                                description: 'Galpão destinado para cargas internacionais')
     Warehouse.create(name: 'Rio', code: 'SDU', city:'Rio de Janeiro', 
                                  area: 60_000, address: 'Av. do porto, 1000', 
                                  cep:'12345-678' , description: 'Galpão do Rio')

    supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', 
                                registration_number: CNPJ.generate,
                                full_address: 'Av das palmas, 100', city:'Bauru', 
                                state: 'SP', email: 'contato@gmail.com')
    Supplier.create!(brand_name:'Samsung', corporate_name: 'Samsung Eletronicos LTDA', 
                                registration_number: CNPJ.generate, full_address: 'Av Nações Unidas, 1000',
                                city: 'São Paulo', state: 'SP', email:'sac@samsung.com.br')
    #act
    visit root_path
    login_as(subject)
    click_on 'Registrar Pedido'
    select warehouse.name, from: 'Galpão Destino'
    select supplier.corporate_name, from: "Fornecedor"
    fill_in "Data Prevista de Entrega",	with: "20/12/2022" 
    click_on 'Gravar'
    #assert
    expect(page).to have_content 'Pedido registrado com sucesso.'
    expect(page).to have_content 'Galpão Destino: Aeroporto SP'
    expect(page).to have_content "Usuário Responsável: #{subject.name} <#{subject.email}>"
    expect(page).to have_content "Fornecedor: #{supplier.corporate_name}"
    expect(page).to have_content "Data Prevista de Entrega: 20/12/2022"

    expect(page).not_to have_content 'Galpão Rio'
    expect(page).not_to have_content 'Samsung Eletrônicos LTDA'
  end
end
