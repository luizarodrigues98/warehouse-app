class ProductModel < ApplicationRecord
  belongs_to :supplier
  validates :name, :sku, :weight, :width, :height, :depth, presence: :true
  validates :sku, uniqueness: true
  validates_length_of :sku, is: 20
  validates :weight, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :width, numericality: { only_integer: true, greater_than_or_equal_to: 1 } 
  validates :height, numericality: { only_integer: true, greater_than_or_equal_to: 1 } 
  validates :depth, numericality: { only_integer: true, greater_than_or_equal_to: 1 }


end
