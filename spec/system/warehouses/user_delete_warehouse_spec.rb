require 'rails_helper'

describe "Usuário remove um galpão" do
  subject { create(:user) } 
  
  it 'com sucesso' do
    #arrange
    w = Warehouse.create!(name:'Cuiabá', code: 'CWB', area:'10000', cep: '56000-000', 
                        address:'Av. dos Jacarés, 1000', city:'Cuiabá', 
                        description: 'Galpão no centro do país')
    #act
    visit root_path
    login_as(subject)
    visit root_path
    click_on 'Cuiabá'
    click_on 'Remover'
    #assert
    expect(current_path).to eq root_path
    expect(page).to have_content 'Galpão removido com sucesso'
    expect(page).not_to have_content 'Cuiabá'  
    expect(page).not_to have_content 'CWB'  
  end 
  
  it "e não apaga outros galpões" do
    #arrange
    first_warehouse = Warehouse.create!(name:'Cuiabá', code: 'CWB', area:'10000', cep: '56000-000', 
                                        address:'Av. dos Jacarés, 1000', city:'Cuiabá', 
                                        description: 'Galpão no centro do país')
    second_warehouse = Warehouse.create!(name:'Belo Horizonte', code: 'BHZ', area:'20000', cep: '46000-000', 
                                        address:'Av. Tiradentes, 20', city:'Belo Horizonte', 
                                        description: 'Galpão para cargas mineiras')
    #act
    visit root_path
    login_as(subject)
    visit root_path

    click_on 'Cuiabá'
    click_on 'Remover'
    #assert
    expect(current_path).to eq root_path
    expect(page).to have_content 'Galpão removido com sucesso'
    expect(page).to have_content 'Belo Horizonte'
    expect(page).not_to have_content 'Cuiabá'  
  end
  
end
