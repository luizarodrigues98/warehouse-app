require 'rails_helper'

describe "Usuário edita pedidos" do
  before(:each) do
    @user = create(:user) 
    @warehouse = create(:warehouse)
    @supplier = create(:supplier)
    @order = create(:order, user: @user, warehouse: @warehouse, supplier: @supplier)
  end

  it 'e deve estar autenticado' do
    visit edit_order_path(@order.id)
    expect(current_path).to eq new_user_session_path

  end

  it 'com sucesso' do
    second_supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', 
                                registration_number: CNPJ.generate,
                                full_address: 'Av das palmas, 100', city:'Bauru', 
                                state: 'SP', email: 'contato@gmail.com')
    login_as(@user)
    visit root_path
    click_on 'Meus Pedidos'
    click_on @order.code
    click_on 'Editar'
    fill_in 'Data Prevista de Entrega', with: '12/12/2022'
    select second_supplier.corporate_name, from: 'Fornecedor'
    click_on 'Gravar'
    expect(page).to have_content 'ACME LTDA'
    expect(page).to have_content '12/12/2022'
  end

  it 'caso seja o responsável' do
    luiza_user = User.create!(name: 'Luiza', email: 'luiza@teste.com', password: 'password')
    login_as(luiza_user)
    visit edit_order_path(@order.id)
    expect(current_path).to eq root_path

  end
end