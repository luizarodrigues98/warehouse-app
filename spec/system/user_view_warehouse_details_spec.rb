require 'rails_helper'
describe "Usuário ver detalhes de um galpão" do
  it 'e vê informações adicionais' do
    #ARRANGE
    Warehouse.create(name:'Aeroporto SP', code:'GRU' , city: 'Guarulhos', area: 100_000,
                      address: 'Avenida do Aeroporto, 100', cep: '1500-000',
                     description: 'Galpão destinado para cargas internacionais')
    #ACT
    visit('/') 
    click_on('Aeroporto SP')
    #ASSERT
    expect(page).to have_content('Galpão GRU')
    expect(page).to have_content('Nome: Aeroporto SP')
    expect(page).to have_content('Cidade: Guarulhos')
    expect(page).to have_content('Área: 100000 m2')
    expect(page).to have_content('Endereço: Avenida do Aeroporto, 100 CEP: 1500-000')
    expect(page).to have_content('Galpão destinado para cargas internacionais')
  end
end
