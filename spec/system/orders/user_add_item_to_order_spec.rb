require 'rails_helper'

describe "Usuário adiciona itens ao pedidos" do
  before(:each) do
    @user = create(:user) 
    @warehouse = create(:warehouse)
    @supplier = create(:supplier)
    @order = create(:order, user: @user, warehouse: @warehouse, supplier: @supplier)
  end

  it 'com sucesso' do


    a_product = ProductModel.create!(name:'Produto A', weight: 8000, width: 70, height: 45, depth: 10,  
                                     sku: 'TV32-SAMSU-XSPTOX959', supplier: @supplier)
    b_product = ProductModel.create!(name:'Produto B', weight: 3000, width: 80, height: 15, depth: 20,
                                    sku:'SOU71-SAMSU-NOI27710', supplier: @supplier)

    login_as(@user)
    visit root_path
    click_on 'Meus Pedidos'
    click_on @order.code
    click_on 'Adicionar Item'
    select "Produto A",	from: "Produto" 
    fill_in "Quantidade", with: '8'
    click_on 'Gravar'

    expect(current_path).to eq order_path(@order.id)
    expect(page).to have_content 'Item adicionado com sucesso'  
    expect(page).to have_content '8 x Produto A'  

  end

  it 'e não vê produtos de outro fornecedor' do
    supplier_b = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', 
      registration_number: CNPJ.generate,
      full_address: 'Av das palmas, 100', city:'Bauru', 
      state: 'SP', email: 'contato@gmail.com')
    a_product = ProductModel.create!(name:'Produto A', weight: 8000, width: 70, height: 45, depth: 10,  
      sku: 'TV32-SAMSU-XSPTOX959', supplier: @supplier)
    b_product = ProductModel.create!(name:'Produto B', weight: 3000, width: 80, height: 15, depth: 20,
      sku:'SOU71-SAMSU-NOI27710', supplier: supplier_b)

    login_as(@user)
    visit root_path
    click_on 'Meus Pedidos'
    click_on @order.code    
    click_on 'Adicionar Item'
    expect(page).to have_content 'Produto A'
    expect(page).not_to have_content 'Produto B'

  end


end