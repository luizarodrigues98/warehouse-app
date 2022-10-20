require 'rails_helper'

describe "Warehouse API" do
  context 'GET/api/v1/warehouses/1' do
    it 'success' do
      #arrange
      warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos',
                                    area: 100_000, address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                                    description: 'Galpão destinado para cargas internacionais')
      #act 
      get "/api/v1/warehouses/#{warehouse.id}"
      #assert
      expect(response.status).to eq 200
      expect(response.content_type).to include('application/json')
    
      json_response = JSON.parse(response.body)
      expect(json_response["name"]).to eq('Aeroporto SP')
      expect(json_response["code"]).to eq('GRU')
      expect(json_response.keys).not_to include('created_at')
      expect(json_response.keys).not_to include('updated_at')
    end
    
    it 'fail if warehouse not found' do
      #act 
      get "/api/v1/warehouses/9999999"
      #assert    
      expect(response.status).to eq 404
    end
  end

  context 'GET/api/v1/warehouses' do
    it 'list all warehouser ordered by name' do
      #arrange
      Warehouse.create!(name: 'São Paulo', code: 'GRU', city: 'Guarulhos',
                                    area: 100_000, address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                                    description: 'Galpão destinado para cargas internacionais')
      Warehouse.create!(name:'Cuiabá', code: 'CWB', area:'10000', cep: '56000-000', 
                                          address:'Av. dos Jacarés, 1000', city:'Cuiabá', 
                                          description: 'Galpão no centro do país')
        #act 
      get "/api/v1/warehouses/"
      #assert
      expect(response.status).to eq 200
      expect(response.content_type).to include('application/json')      
      
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq 2
      expect(json_response[0]["name"]).to eq 'Cuiabá'
      expect(json_response[1]["name"]).to eq 'São Paulo'
    end

    it 'return empty if there is no warehouse' do
      get "/api/v1/warehouses"

      expect(response.status).to eq 200
      expect(response.content_type).to include('application/json')
      json_response = JSON.parse(response.body)
      expect(json_response).to eq []
      
    end
    it 'and raise internal error' do
      allow(Warehouse).to receive(:all).and_raise(ActiveRecord::QueryCanceled)
      
      get '/api/v1/warehouses'
      
      expect(response).to have_http_status(500)
    end
  end
  context 'POST /api/v1/warehouses' do
    it 'success' do
      #arrange
      warehouse_params = { warehouse: { name: 'Aeroporto SP', code: 'GRU',
                          city: 'Guarulhos', area: 100_000, address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                          description: 'Galpão destinado para cargas internacionais'}}
      #act
      post '/api/v1/warehouses', params: warehouse_params
      #assert
      expect(response).to have_http_status(:created)
      expect(response.content_type).to include('application/json')

      json_response = JSON.parse(response.body)
      expect(json_response["name"]).to eq('Aeroporto SP')
      expect(json_response["code"]).to eq('GRU')
      expect(json_response["city"]).to eq('Guarulhos')
      expect(json_response["area"]).to eq(100_000)
      expect(json_response["address"]).to eq('Avenida do Aeroporto, 1000')
      expect(json_response["cep"]).to eq('15000-000')
      expect(json_response["description"]).to eq('Galpão destinado para cargas internacionais')

    end

    it 'fail if parameters are not complete' do
      #arrange
      warehouse_params = { warehouse: { name: 'Aeroporto Curitiba', code: 'CWB'}}
      #act
      post '/api/v1/warehouses', params: warehouse_params
      #assert
      expect(response).to have_http_status(412)
      expect(response.body).to include('Cidade não pode ficar em branco')
      expect(response.body).not_to include('Nome não pode ficar em branco')
      expect(response.body).not_to include('Código não pode ficar em branco')
    end
    it 'fail if theres an internal error' do
      #arrange
      allow(Warehouse).to receive(:new).and_raise(ActiveRecord::ActiveRecordError)
      warehouse_params = { warehouse: { name: 'Aeroporto SP', code: 'GRU',
                          city: 'Guarulhos', area: 100_000, address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                          description: 'Galpão destinado para cargas internacionais'}}
      #act
      post '/api/v1/warehouses', params: warehouse_params
      #assert
      expect(response).to have_http_status(500)
      
    end
  end
end