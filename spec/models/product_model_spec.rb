require 'rails_helper'
RSpec.describe ProductModel, type: :model do
  describe '#valid?' do
    it 'name is mandatory' do
      supplier = Supplier.new(brand_name:'Samsung', corporate_name: 'Samsung Eletronicos LTDA', 
                            registration_number: '9876544322100', full_address: 'Av Nações Unidas, 1000',
                            city: 'São Paulo', state: 'SP', email:'sac@samsung.com.br')
      pm = ProductModel.new(name:'', weight: 8000, width: 70, height: 45, depth: 10,  
                            sku: 'TV32-SAMSU-XPTO90', supplier: supplier)
      result = pm.valid?
      expect(result).to eq false

    end
    it 'SKU is mandatory' do
      supplier = Supplier.new(brand_name:'Samsung', corporate_name: 'Samsung Eletronicos LTDA', 
                            registration_number: '9876544322100', full_address: 'Av Nações Unidas, 1000',
                            city: 'São Paulo', state: 'SP', email:'sac@samsung.com.br')
      pm = ProductModel.new(name:'TV 32 polegadas', weight: 8000, width: 70, height: 45, depth: 10,  
                            sku: '', supplier: supplier)
      
      expect(pm).to_not be_valid

    end
  end
end
