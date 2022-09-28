require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#description' do
    it 'exibe o nome e o email' do
      user = create(:user)
      result = user.description()
      expect(result).to eq("#{user.name} - #{user.email}" ) 
    end
  end
end
