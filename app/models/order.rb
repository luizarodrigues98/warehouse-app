class Order < ApplicationRecord
  CODE_LENGTH = 10.freeze

  belongs_to :warehouse
  belongs_to :supplier
  belongs_to :user  
  has_many :order_items
  has_many :product_models, through: :order_items

  enum status: { pending: 0, delivered: 5, canceled: 9}

  validates :estimated_delivery_date, presence: :true
  validates :estimated_delivery_date, future_date: true
  validates :code , presence: :true
  before_validation :generate_code, on: :create

  
  private
  def generate_code
    self.code = SecureRandom.alphanumeric(Order::CODE_LENGTH).upcase
  end
end
