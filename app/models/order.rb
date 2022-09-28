class Order < ApplicationRecord
  belongs_to :warehouse
  belongs_to :supplier
  belongs_to :user
  
  
  validates :estimated_delivery_date, future_date: true
end