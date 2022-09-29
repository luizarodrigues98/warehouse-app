require 'rails_helper'

describe "Usuário edita um pedidos" do
  before(:each) do
    @user = create(:user) 
    @warehouse = create(:warehouse)
    @supplier = create(:supplier)
    @order = create(:order, user: @user, warehouse: @warehouse, supplier: @supplier)
  end

  it 'e não é o dono' do
    luiza_user = User.create!(name: 'Luiza', email: 'luiza@teste.com', password: 'password')
    login_as(luiza_user)
    patch(order_path(@order.id))
    expect(response).to redirect_to(root_path)
  end
end