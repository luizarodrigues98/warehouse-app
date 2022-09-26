require 'rails_helper'



describe "Usuário se autentica" do
  subject { create(:user) } 
  it 'com sucesso' do
    visit root_path
    click_on 'Entrar'
    within('form') do
      fill_in "E-mail",	with: subject.email 
      fill_in "Senha",	with: subject.password 
      click_on 'Entrar'
    end
    within('nav') do
      expect(page).not_to  have_link 'Entrar' 
      expect(page).to have_button 'Sair'
      expect(page).to have_content subject.email 
    end
  end

  it 'espera ver uma mensagem de sucesso' do
    visit root_path
    click_on 'Entrar'
    within('form') do
      fill_in "E-mail",	with: subject.email 
      fill_in "Senha",	with: subject.password 
      click_on 'Entrar'
    end
    expect(page).to have_content "Login efetuado com sucesso."
  end

  it 'e faz logout' do
    visit root_path
    click_on 'Entrar'
    within('form') do
      fill_in "E-mail",	with: subject.email 
      fill_in "Senha",	with: subject.password 
      click_on 'Entrar'
    end
    click_on 'Sair'
    expect(page).to have_content 'Logout efetuado com sucesso.'
    expect(page).to have_link 'Entrar' 
    expect(page).not_to have_button 'Sair' 
  end
end
