class Supplier < ApplicationRecord

  validates :corporate_name, :brand_name, :registration_number, :email, presence: true
  validates :registration_number, uniqueness: true
  validates_length_of :registration_number, is: 13
end
