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
    expect(page).to have_content 'Itens em Estoque' 
    expect(page).to have_content '3 x TV32-SAMSU-XSPTOX959' 
    expect(page).to have_content '2 x NOTEI5-SAMSU-NOTITLI' 
    expect(page).not_to have_content 'SOU71-SAMSU-NOI27710' 


  end
end