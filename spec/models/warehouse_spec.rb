require 'rails_helper'

RSpec.describe Warehouse, type: :model do
  describe 'valid?' do
    context "presence" do
          
      it 'false when name is empty' do
        warehouse = Warehouse.new(name:'', code: 'Rio', address: 'Endereço',
                                  cep:'25000-00', city: 'Rio', area: 1000, 
                                description: 'Alguma descrição')
        #act
        result = warehouse.valid?
        #assert
        expect(result).to eq false 

      end  
      it 'false when code is empty' do
        warehouse = Warehouse.new(name:'Rio', code: '', address: 'Endereço',
                                  cep:'25000-00', city: 'Rio', area: 1000, 
                                description: 'Alguma descrição')
        #act
        result = warehouse.valid?
        #assert
        expect(result).to eq false 

      end  
      it 'false when address is empty' do
        warehouse = Warehouse.new(name:'Rio', code: 'Rio', address: '',
                                  cep:'25000-00', city: 'Rio', area: 1000, 
                                description: 'Alguma descrição')
        #act
        result = warehouse.valid?
        #assert
        expect(result).to eq false 

      end  
    end
    
    it 'false when code is already in use' do
      #arrange: criar dois galpões e repetir o cdigo
      first_warehouse = Warehouse.create(name:'Rio', code: 'Rio', address: 'Endereço',
                                      cep:'25000-00', city: 'Rio', area: 1000, 
                                      description: 'Alguma descrição')
      second_warehouse =  Warehouse.new(name:'Niteroi', code: 'Rio', address: 'Avenida',
                                        cep:'35000-00', city: 'Niteroi', area: 1500, 
                                        description: 'Alguma descrição')                                
      #act: perguntar pro segundo galpão se ele é valido, fiz essa etapa dentro do assert
      #assert:: espero que seja false 
      expect(second_warehouse.valid?).to be_falsey
      #poderia usar também:  expect(second_warehouse.valid?).not_to be_valid
    end
  end

  describe "#full_description" do
    it 'exibe o nome e o código' do
      w = Warehouse.new(name:'Galpão Cuiabá', code:'CBA' )
    end
  end
  
end
