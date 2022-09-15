class Warehouse < ApplicationRecord
  validates :name, :code, :city, :address, :cep, :description, presence: true
end
