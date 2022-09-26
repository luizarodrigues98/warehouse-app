class Warehouse < ApplicationRecord
  validates :name, :code, :city, :address, :cep, :description, presence: true
  validates :name, :code, uniqueness: true
  validates :cep, length: [is: 8] 
  
end

