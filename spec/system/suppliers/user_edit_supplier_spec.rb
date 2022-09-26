require 'rails_helper'

describe "Usuário edita um fornecedor" do
  it 'a partir da pagina de detalhes' do
    supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: CNPJ.generate,
      full_address: 'Av das palmas, 100', city:'Bauru', state: 'SP', email: 'contato@gmail.com')

    visit suppliers_path
    click_on 'ACME'
    click_on 'Editar'
    expect(page).to have_content 'Editar Fornecedor'
    expect(page).to have_field('Nome corporativo', with: supplier.corporate_name)
    expect(page).to have_field('Nome fantasia', with: supplier.brand_name)
    expect(page).to have_field('CNPJ', with: supplier.registration_number)
    expect(page).to have_field('Cidade', with: supplier.city)
    expect(page).to have_field('Estado', with: supplier.state)
    expect(page).to have_field('Endereço', with: supplier.full_address)
    expect(page).to have_field('Email', with: supplier.email)  
  end

  it 'com sucesso' do
    supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: CNPJ.generate,
                      full_address: 'Av das palmas, 100', city:'Bauru', state: 'SP', email: 'contato@gmail.com')
    visit suppliers_path
    click_on 'ACME'
    click_on 'Editar'
    fill_in "Nome corporativo",	with: 'ACME LTDA BRASIL'
    fill_in "Nome fantasia",	with: "ACME2"
    fill_in "CNPJ",	with: CNPJ.generate
    fill_in "Email",	with: "acme@contato.com.br"
    click_on 'Enviar' 
    supplier.reload
    expect(page).to have_content 'Fornecedor atualizado com sucesso'
    expect(page).to have_content supplier.corporate_name
    expect(page).to have_content supplier.registration_number
    expect(page).to have_content supplier.brand_name
    expect(page).to have_content supplier.email
  end  
  it "e mantém os campos obrigatórios" do
      Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: CNPJ.generate,
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