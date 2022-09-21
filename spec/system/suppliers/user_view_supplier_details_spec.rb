require 'rails_helper'

describe 'Usuário vê detalhes do fornecedor' do
  it 'a partir da tela inicial' do
    Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '1234567891000',
      full_address: 'Av das palmas, 100', city:'Bauru', state: 'SP', email: 'contato@gmail.com')

    visit root_path
    click_on 'Fornecedores'
    click_on 'ACME'

    expect(page).to have_content('ACME LTDA')
    expect(page).to have_content('Documento: 1234567891000')
    expect(page).to have_content('Endereço: Av das palmas, 100')

  end
  it 'e volta para a tela de fornecedores' do
    Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '1234567891000',
      full_address: 'Av das palmas, 100', city:'Bauru', state: 'SP', email: 'contato@gmail.com')

    visit root_path
    click_on 'Fornecedores'
    click_on 'ACME'
    click_on 'Voltar'  
    expect(current_path).to eq suppliers_path
  end
end