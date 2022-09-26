require 'rails_helper'

RSpec.describe Supplier, type: :model do
  describe 'valid?' do
    context "presence" do
          
      it 'false when brand name is empty' do
        supplier = Supplier.new(corporate_name: 'ACME LTDA', brand_name: '', registration_number: CNPJ.generate,
          full_address: 'Av das palmas, 100', city:'Bauru', state: 'SP', email: 'contato@gmail.com')
        result = supplier.valid?
        expect(result).to eq false
      end
      it 'false when corporate name is empty' do
        supplier = Supplier.new(corporate_name: '', brand_name: 'ACME', registration_number: CNPJ.generate,
          full_address: 'Av das palmas, 100', city:'Bauru', state: 'SP', email: 'contato@gmail.com')
        result = supplier.valid?
        expect(result).to eq false
      end   
      it 'false when registration_number is double' do
        supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: CNPJ.generate,
          full_address: 'Av das palmas, 100', city:'Bauru', state: 'SP', email: 'contato@gmail.com')
        other_supplier = Supplier.new(corporate_name: 'Spark Industries Brasil LTDA', brand_name: 'Spark', registration_number: supplier.registration_number,
          full_address: 'Torre da Industria, 1', city:'Teresina', state: 'PI', email: 'contato@gmail.com')

        result = other_supplier.valid?
        expect(result).to eq false
      end 
    end
  end
end
