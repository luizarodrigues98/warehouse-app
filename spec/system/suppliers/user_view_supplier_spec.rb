require 'rails_helper'

describe 'Usuário vê fornecedores' do
  subject { create(:user) } 
  
  it 'a partir do menu' do
    #arrange
    #Act
    visit(root_path)
    login_as(subject)
    within('nav') do
      click_on 'Fornecedores'
    end
    #Assert
    expect(current_path).to eq suppliers_path  
  end

  it 'com sucesso' do
    Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: CNPJ.generate,
                      full_address: 'Av das palmas, s100', city:'Bauru', state: 'SP', email: 'contato@gmail.com')
    Supplier.create!(corporate_name: 'Spark Industries Brasil LTDA', brand_name: 'Spark', registration_number: CNPJ.generate,
                      full_address: 'Torre da Industria, 1', city:'Teresina', state: 'PI', email: 'contato@gmail.com')
    
    visit root_path
    login_as(subject)
    click_on 'Fornecedores'

    expect(page).to have_content('Fornecedores')  
    expect(page).to have_content('ACME')
    expect(page).to have_content('Bauru - SP')  
    expect(page).to have_content('Spark')  
    expect(page).to have_content('Teresina - PI')  

  end

  it 'e não existem fornecedores cadastrados' do
    visit root_path
    login_as(subject)
    click_on 'Fornecedores'
    expect(page).to have_content('Não existem fornecedores cadastrados')  
    
  end
end