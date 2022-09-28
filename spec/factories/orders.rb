FactoryBot.define do
  factory :order do
    estimated_delivery_date { Date.today + 7.days }
  end
end
