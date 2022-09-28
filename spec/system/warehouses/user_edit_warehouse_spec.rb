require 'rails_helper'

describe "Usuário edita um galpão" do
  before(:each) do
    @warehouse = create(:warehouse)
  end
  subject { create(:user) } 

  it 'a partir da página de detalhes' do
    
    #act: abrir o app, visitar o galpao, clicar em "Editar"
    visit root_path
    login_as(subject)
    visit root_path
    click_on @warehouse.name
    click_on 'Editar'
    #assert
    expect(page).to have_content 'Editar Galpão'
    expect(page).to have_field('Código', with:'GRU')
    expect(page).to have_field('Nome', with: @warehouse.name)
    expect(page).to have_field('Cidade', with: @warehouse.city)
    expect(page).to have_field('Área', with:100_000)
    expect(page).to have_field('Endereço', with: @warehouse.address)
    expect(page).to have_field('Descrição', with:'Galpão destinado para cargas internacionais')  
  end
  it 'com sucesso' do
    
    visit root_path
    login_as(subject)
    visit root_path
    click_on @warehouse.name
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

    visit root_path
    login_as(subject)
    visit root_path
    click_on @warehouse.name
    click_on 'Editar'
    fill_in "Nome",	with: ""
    fill_in "Área",	with: ""
    fill_in "Endereço",	with: ""
    click_on 'Enviar'

    expect(page).to have_content 'Não foi possível atualizar o galpão'
  end
  
end
 