require 'rails_helper'

describe "Usuário vê todos os modelos de um produto dentro da página de detalhes" do
  it 'com sucesso' do
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
end
