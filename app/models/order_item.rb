class OrderItem < ApplicationRecord
  belongs_to :product_model
  belongs_to :order
  
  validates :quantity, presence: :true
  validates :quantity, numericality: { only_integer: true, greater_than_or_equal_to: 1 }

end
