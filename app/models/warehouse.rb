class Warehouse < ApplicationRecord
  validates :name, :code, :city, :address, :cep, :description, presence: true
  validates :name, :code, uniqueness: true
  validates :cep, length: {is: 9}
  has_many :stock_products
  def full_description
    "#{code} - #{name}"
  end
end

