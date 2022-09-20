require 'rails_helper'

describe "Usuário remove um fornecedor" do
  it 'com sucesso' do
    Supplier.create!(corporate_name: 'Spark Industries Brasil LTDA', brand_name: 'Spark', registration_number: '1234567891011',
                      full_address: 'Torre da Industria, 1', city:'Teresina', state: 'PI', email: 'contato@gmail.com')
    #act
    visit suppliers_path
    click_on 'Spark'
    click_on 'Remover'
    expect(current_path).to eq suppliers_path
    expect(page).to have_content 'Fornecedor removido com sucesso'
    expect(page).not_to have_content 'Spark'
  end
  it 'e não apaga outros fornecedores' do
    first_supplier = Supplier.create!(corporate_name: 'Spark Industries Brasil LTDA', brand_name: 'Spark', registration_number: '1234567891011',
                                      full_address: 'Torre da Industria, 1', city:'Teresina', state: 'PI', email: 'contato@gmail.com')
    second_supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '1234567891000',
                                        full_address: 'Av das palmas, 100', city:'Bauru', state: 'SP', email: 'contato@gmail.com')
    visit suppliers_path
    click_on 'ACME'
    click_on 'Remover'
    expect(current_path).to eq suppliers_path
    expect(page).to have_content 'Fornecedor removido com sucesso'
    expect(page).to have_content 'Spark'
    expect(page).not_to have_content 'ACME' 
  end

end