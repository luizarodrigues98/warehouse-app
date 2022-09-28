require 'rails_helper'

describe "Usuário se autentica" do
  it 'com sucesso' do
    #arrange
    user = User.create!(name: "Maria", email: 'maria@email.com', password:'password')
    #act
    visit root_path
    within('form') do
      fill_in "E-mail",	with: "maria@email.com" 
      fill_in "Senha",	with: "password" 
      click_on 'Entrar'
    end
    within('nav') do
      expect(page).not_to have_link 'Entrar' 
      expect(page).to have_button 'Sair'
      expect(page).to have_content "#{user.name} - #{user.email} "
    end
  end

  it 'espera ver uma mensagem de sucesso' do
    user = User.create!(name: "Maria", email: 'maria@email.com', password:'password')
    visit root_path
    within('form') do
      fill_in "E-mail",	with: "maria@email.com" 
      fill_in "Senha",	with: "password" 
      click_on 'Entrar'
    end
    expect(page).to have_content "Login efetuado com sucesso."
  end

  it 'e faz logout' do
    user = User.create!(name: "Maria", email: 'maria@email.com', password:'password')
    
    visit root_path
    within('form') do
      fill_in "E-mail",	with: "maria@email.com" 
      fill_in "Senha",	with: "password" 
      click_on 'Entrar'
    end   
    visit root_path
    click_on 'Sair'
    expect(page).to have_content 'Para continuar, faça login ou registre-se'

    expect(page).to have_link 'Entrar' 
    expect(page).not_to have_button 'Sair' 
   end
end
