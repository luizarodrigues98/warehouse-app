require 'rails_helper'

describe "Usuário vê seus próprios pedidos" do

  subject { create(:user) } 

  it 'e deve estar autenticado' do
    visit root_path
    click_on 'Meus Pedidos'

    expect(current_path).to eq new_user_session_path
  end

  it 'e não vê outros pedidos' do
    luiza_user = User.create!(name: 'Luiza', email: 'luiza@teste.com', password: 'password')
    warehouse = create(:warehouse)
    supplier = create(:supplier)
    first_order = create(:order, user: luiza_user, warehouse: warehouse, supplier: supplier)
    second_order = create(:order, user:subject , warehouse: warehouse, supplier: supplier)
    third_order = create(:order, estimated_delivery_date: 1.week.from_now, user: luiza_user , warehouse: warehouse, supplier: supplier)
  
    
    login_as(luiza_user)
    visit root_path
    click_on 'Meus Pedidos'

    expect(page).to have_content first_order.code
    expect(page).not_to have_content second_order.code
    expect(page).to have_content third_order.code
    
  end

  it 'e visita um pedido' do
    warehouse = create(:warehouse)
    supplier = create(:supplier)
    luiza_user = User.create!(name: 'Luiza', email: 'luiza@teste.com', password: 'password')
    
    first_order = create(:order, user: luiza_user, warehouse: warehouse, supplier: supplier)
    
    order = create(:order, user:subject , warehouse: warehouse, supplier: supplier)
    
    login_as(luiza_user)
    visit root_path
    click_on 'Meus Pedidos'
    click_on first_order.code
    expect(page).to have_content 'Detalhes do Pedido'
    expect(page).to have_content first_order.code
    expect(page).to have_content "Galpão Destino: #{first_order.warehouse.full_description}"
    expect(page).to have_content "Fornecedor: #{first_order.supplier.corporate_name}"
    formatted_date = I18n.localize( Date.today + 7.days)
    expect(page).to have_content formatted_date

  end

  it 'e não visita pedidos de outro usuário' do
    luiza_user = User.create!(name: 'Luiza', email: 'luiza@teste.com', password: 'password')
    warehouse = create(:warehouse)
    supplier = create(:supplier)
    first_order = create(:order, user: luiza_user, warehouse: warehouse, supplier: supplier)
    
    order = create(:order, user:subject , warehouse: warehouse, supplier: supplier)
    
    login_as(subject)
    visit order_path(first_order.id)

    expect(current_path).not_to eq order_path(first_order.id) 
    expect(current_path).to eq root_path 
    expect(page).to have_content 'Você não possui acesso a esse pedido' 

  end

end