require 'rails_helper'

describe "Usuário edita um galpão" do
  it 'a partir da página de detalhes' do
    #arrange: criar um galpão no banco de dados
    warehouse = Warehouse.create!(name:'Aeroporto SP', code:'GRU' , city: 'Guarulhos', area: 100_000,
                                address: 'Avenida do Aeroporto, 100', cep: '1500-000',
                                description: 'Galpão destinado para cargas internacionais')
    #act: abrir o app, visitar o galpao, clicar em "Editar"
    visit root_path
    click_on 'Aeroporto SP'
    click_on 'Editar'
    #assert
    expect(page).to have_content 'Editar Galpão'
    expect(page).to have_field('Código', with:'GRU')
    expect(page).to have_field('Nome', with:'Aeroporto SP')
    expect(page).to have_field('Cidade', with:'Guarulhos')
    expect(page).to have_field('Área', with:100_000)
    expect(page).to have_field('Endereço', with:'Avenida do Aeroporto, 100')
    expect(page).to have_field('Descrição', with:'Galpão destinado para cargas internacionais')  
  end
  it 'com sucesso' do
    warehouse = Warehouse.create!(name:'Galpão Internacional', code:'GRU' , city: 'Guarulhos', area: 200_000,
                                  address: 'Av. dos Galpões, 100', cep: '1500-000',
                                  description: 'Galpão destinado para cargas internacionais')
    visit root_path
    click_on 'Galpão Internacional'
    click_on 'Editar'
    fill_in "Nome",	with: "Galpão Internacional"
    fill_in "Área",	with: "20000"
    fill_in "Endereço",	with: "Av. dos Galpões, 100"
    click_on 'Enviar'
    expect(page).to have_content 'Galpão atualizado com sucesso' 
    expect(page).to have_content 'Galpão Internacional'
    expect(page).to have_content 'Endereço: Av. dos Galpões, 100'
    expect(page).to have_content 'Área: 20000 m2'
  end
  
  it "e mantém os campos obrigatórios" do
    warehouse = Warehouse.create!(name:'Aeroporto SP', code:'GRU' , city: 'Guarulhos', area: 100_000,
                  address: 'Avenida do Aeroporto, 100', cep: '1500-000',
                  description: 'Galpão destinado para cargas internacionais')
      visit root_path
      click_on 'Aeroporto SP'
      click_on 'Editar'
      fill_in "Nome",	with: ""
      fill_in "Área",	with: ""
      fill_in "Endereço",	with: ""
      click_on 'Enviar'

      expect(page).to have_content 'Não foi possível atualizar o galpão'
  end
  
end
 