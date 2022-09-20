require 'rails_helper'

describe "Usuário edita um fornecedor" do
  it 'a partir da pagina de detalhes' do
    Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '1234567891000',
      full_address: 'Av das palmas, 100', city:'Bauru', state: 'SP', email: 'contato@gmail.com')

    visit suppliers_path
    click_on 'ACME'
    click_on 'Editar'
    expect(page).to have_content 'Editar Fornecedor'
    expect(page).to have_field('Nome corporativo', with:'ACME LTDA')
    expect(page).to have_field('Nome fantasia', with:'ACME')
    expect(page).to have_field('CNPJ', with:'1234567891000')
    expect(page).to have_field('Cidade', with:'Bauru')
    expect(page).to have_field('Estado', with:'SP')
    expect(page).to have_field('Endereço', with:'Av das palmas, 100')
    expect(page).to have_field('Email', with:'contato@gmail.com')  
  end
  it 'com sucesso' do
    Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '1234567891000',
                      full_address: 'Av das palmas, 100', city:'Bauru', state: 'SP', email: 'contato@gmail.com')
    visit suppliers_path
    click_on 'ACME'
    click_on 'Editar'
    fill_in "Nome corporativo",	with: "ACME LTDA BRASIL"
    fill_in "Nome fantasia",	with: "ACME2"
    fill_in "CNPJ",	with: "1234567891011"
    fill_in "Email",	with: "acme@contato.com.br"
    click_on 'Enviar' 
    expect(page).to have_content 'Fornecedor atualizado com sucesso'
    expect(page).to have_content 'ACME LTDA BRASIL'
    expect(page).to have_content '1234567891011'
    expect(page).to have_content 'ACME2'
    expect(page).to have_content 'acme@contato.com.br'

  end  
  it "e mantém os campos obrigatórios" do
      Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '1234567891000',
                        full_address: 'Av das palmas, 100', city:'Bauru', state: 'SP', email: 'contato@gmail.com')
      visit suppliers_path
      click_on 'ACME'
      click_on 'Editar'
      fill_in "Nome corporativo", with: ""
      fill_in "Nome fantasia", with: ""	
      fill_in "CNPJ",	with: ""
      fill_in "Email",	with: ""
      click_on 'Enviar'

      expect(page).to have_content 'Não foi possivel atualizar o fornecedor'
  end
  
end