require 'rails_helper'

describe 'Usuário visita tela inicial' do
  it 'e vê o nome da app' do
    #Act
    visit('/')
    #Assert
    expect(page).to have_content('Galpões & Estoque')  
  end
  # it 'e vê o rodapé' do
    
  # end

  # it 'e vê o menu' do
    
  # end
end