require 'rails_helper'

describe "Usuário cadastra um fornecedor" do
  it 'a partir da tela inicial' do
    #arrange
    #act
    visit root_path
    click_on 'Cadastrar Fornecedor'
    #assert
    expect(page).to have_field('Nome corporativo') 
    expect(page).to have_field('Nome fantasia')
    expect(page).to have_field('CNPJ')    
    expect(page).to have_field('Endereço')
    expect(page).to have_field('Cidade')
    expect(page).to have_field('Estado')
    expect(page).to have_field('Email')

  end

  it 'com sucesso' do
    #act
    visit root_path
    click_on 'Cadastrar Fornecedor'
    fill_in "Nome fantasia",	with: "SHELL"
    fill_in "Nome corporativo",	with: "SHELL BRASIL PETROLEO LTDA"  
    fill_in "CNPJ",	with: CNPJ.generate  
    fill_in "Endereço",	with: "Avenida do Museu do amanhã, 1000"  
    fill_in "Cidade",	with: "Rio de Janeiro"  
    fill_in "Estado",	with: "RJ"  
    fill_in "Email",	with: 'contato@gmail.com'  
    click_on 'Enviar'
    #assert
    expect(current_path).to  eq suppliers_path 
    expect(page).to have_content 'Fornecedor cadastrado com sucesso' 
    expect(page).to have_content 'SHELL'    
    expect(page).to have_content 'Rio de Janeiro - RJ' 
  end

  it 'com dados incompletos' do
    #arrange
    #act
    visit root_path
    click_on 'Cadastrar Fornecedor'
    fill_in "Nome fantasia",	with: ''
    fill_in "Nome corporativo",	with: ''
    fill_in "CNPJ",	with: ''  
    click_on 'Enviar'
    #assert
    expect(page).to have_content 'Fornecedor não cadastrado'
    expect(page).to have_content 'Nome corporativo não pode ficar em branco'
    expect(page).to have_content 'Nome fantasia não pode ficar em branco'
  end
end
 