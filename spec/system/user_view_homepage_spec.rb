require 'rails_helper'

describe 'Usuário visita tela inicial' do
  subject { create(:user) } 

  it 'e vê o nome da app' do
    #Act
    visit(root_path)

    #Assert
    expect(page).to have_content('Galpões & Estoque')  
    expect(page).to have_link('Galpões & Estoque', href: root_url)  
  end
  it 'e vê os galpões cadastrados' do
    Warehouse.create(name: 'Rio', code: 'SDU', city:'Rio de Janeiro', area: 60_000, address: 'Av. do porto, 1000', cep:'12345-678' , description: 'Galpão do Rio')
    Warehouse.create(name: 'Maceio', code: 'MCZ', city:'Maceio', area: 50_000, address: 'Av. Atlântica, 1000', cep:'87654-321', description: 'Perto do Aeroporto')
    
    visit(root_path) 
    login_as(subject)
    visit root_path
    expect(page).not_to have_content('Não existem galpões cadastrados')
    expect(page).to have_content('Rio')
    expect(page).to have_content('Código: SDU')
    expect(page).to have_content('Cidade: Rio de Janeiro')
    expect(page).to have_content('60000 m2')

    expect(page).to have_content('Maceio')
    expect(page).to have_content('Código: MCZ')
    expect(page).to have_content('Cidade: Maceio')
    expect(page).to have_content('50000 m2')
  end

  it 'e não existem galpões cadastrados' do
    # Arrange
    # Act
    visit(root_path) 
    login_as(subject)
    visit root_path
    # Assert
    expect(page).to have_content('Não existem galpões cadastrados')
  end


end