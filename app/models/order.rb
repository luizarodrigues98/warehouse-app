class Order < ApplicationRecord
  CODE_LENGTH = 10

  belongs_to :warehouse
  belongs_to :supplier
  belongs_to :user  
  validates :estimated_delivery_date, presence: :true
  validates :estimated_delivery_date, future_date: true
  validates :code , presence: :true
  before_validation :generate_code
  
  private
  def generate_code
    self.code = SecureRandom.alphanumeric(Order::CODE_LENGTH).upcase
  end
end
