require 'rails_helper'

describe "Usuário vê o estoque" do
 
  it 'na tela do galpão' do
    user = create(:user)
    warehouse = create(:warehouse)
    supplier = create(:supplier)
    order = create(:order, user: user, warehouse: warehouse, supplier: supplier)
    produto_tv = ProductModel.create!(name:'TV 32', weight: 8000, width: 70, height: 45, depth: 10,  
                                         sku: 'TV32-SAMSU-XSPTOX959', supplier: supplier)
    produto_soudbar = ProductModel.create!(name:'SoundBar 7.1 Surrond', weight: 3000, width: 80, height: 15, depth: 20, 
                                            sku:'SOU71-SAMSU-NOI27710', supplier: supplier)

    produto_notebook = ProductModel.create!(name:'Notebool i5 16GB RAM', weight: 3000, width: 80, height: 15, depth: 20, 
                                            sku:'NOTEI5-SAMSU-NOTITLI', supplier: supplier)
    3.times{StockProduct.create(order: order, warehouse: warehouse, product_model: produto_tv)}
    2.times{StockProduct.create(order: order, warehouse: warehouse, product_model: produto_notebook)}
    login_as(user)
    visit root_path
    click_on warehouse.name
    within('section#stock_products') do
      expect(page).to have_content 'Itens em Estoque' 
      expect(page).to have_content '3 x TV32-SAMSU-XSPTOX959' 
      expect(page).to have_content '2 x NOTEI5-SAMSU-NOTITLI' 
      expect(page).not_to have_content 'SOU71-SAMSU-NOI27710' 
    end

  end

  it 'e dá baixa em um item' do
    user = create(:user)
    warehouse = create(:warehouse)
    supplier = create(:supplier)
    order = create(:order, user: user, warehouse: warehouse, supplier: supplier)
    produto_tv = ProductModel.create!(name:'TV 32', weight: 8000, width: 70, height: 45, depth: 10,  
                                         sku: 'TV32-SAMSU-XSPTOX959', supplier: supplier)
    2.times{StockProduct.create(order: order, warehouse: warehouse, product_model: produto_tv)}
    
    login_as(user)
    visit root_path
    click_on warehouse.name
    select 'TV32-SAMSU-XSPTOX959', from: 'Item para Saída'
    fill_in 'Destinatário', with: 'Maria Ferreira'
    fill_in 'Endereço Destino', with: 'Rua das Palmeiras, 100 - Campinas - São Paulo'
    click_on 'Confirmar Retirada'

    expect(current_path).to eq warehouse_path(warehouse.id)  
    expect(page).to have_content 'Item retirado com sucesso'  
    expect(page).to have_content '1 x TV32-SAMSU-XSPTOX959'  
  end
end