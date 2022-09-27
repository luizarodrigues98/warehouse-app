require 'rails_helper'
describe "Usuário vê detalhes de um galpão" do
  subject { create(:user) } 
  
  it 'e vê informações adicionais' do
    #ARRANGE
    Warehouse.create(name:'Aeroporto SP', code:'GRU' , city: 'Guarulhos', area: 100_000,
                      address: 'Avenida do Aeroporto, 100', cep: '15000-000',
                     description: 'Galpão destinado para cargas internacionais')
    #ACT
    visit(root_path) 
    login_as(subject)
    visit root_path
    click_on('Aeroporto SP')
    #ASSERT
    expect(page).to have_content('Galpão GRU')
    expect(page).to have_content('Nome: Aeroporto SP')
    expect(page).to have_content('Cidade: Guarulhos')
    expect(page).to have_content('Área: 100000 m2')
    expect(page).to have_content('Endereço: Avenida do Aeroporto, 100 CEP: 15000-000')
    expect(page).to have_content('Galpão destinado para cargas internacionais')
  end

  it 'e volta para a tela inicial' do
    #arrange: criar um galpão
    Warehouse.create(name:'Aeroporto SP', code:'GRU' , city: 'Guarulhos', area: 100_000,
                    address: 'Avenida do Aeroporto, 100', cep: '15000-000',
                    description: 'Galpão destinado para cargas internacionais')
    #act: visital a tela inicial, clicar no nome do galpao, clical em 'voltar'
    visit root_path
    login_as(subject)
    visit root_path
    click_on 'Aeroporto SP'
    click_on 'Voltar'
    #assert: espero boltar para tela inicial
    expect(current_path).to eq(root_path)
  end
end
