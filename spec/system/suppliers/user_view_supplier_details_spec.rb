require 'rails_helper'

describe 'Usuário vê detalhes do fornecedor' do
  it 'a partir da tela inicial' do
    supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: CNPJ.generate,
      full_address: 'Av das palmas, 100', city:'Bauru', state: 'SP', email: 'contato@gmail.com')

    visit root_path
    click_on 'Fornecedores'
    click_on 'ACME'

    expect(page).to have_content(supplier.corporate_name)
    expect(page).to have_content(supplier.registration_number)
    expect(page).to have_content(supplier.full_address)

  end

  it 'e vê todos os modelos de produto' do
    supplier = Supplier.create!(brand_name:'Samsung', corporate_name: 'Samsung Eletronicos LTDA', 
      registration_number: CNPJ.generate, full_address: 'Av Nações Unidas, 1000',
      city: 'São Paulo', state: 'SP', email:'sac@samsung.com.br')
    product_model = ProductModel.create!(name:'TV 32', weight: 8000, width: 70, height: 45, depth: 10,  
                     sku: 'TV32-SAMSU-XSPTOX959', supplier: supplier)
  
    visit suppliers_path
    click_on 'Samsung'
    expect(page).to have_content product_model.name
    expect(page).to have_content product_model.sku

  end

  it 'e volta para a tela de fornecedores' do
    Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: CNPJ.generate,
      full_address: 'Av das palmas, 100', city:'Bauru', state: 'SP', email: 'contato@gmail.com')

    visit root_path
    click_on 'Fornecedores'
    click_on 'ACME'
    click_on 'Voltar'  
    expect(current_path).to eq suppliers_path
  end
end