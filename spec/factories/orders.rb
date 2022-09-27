FactoryBot.define do
  factory :order do
    warehouse { nil }
    supplier { nil }
    user { nil }
    estimated_delivery_date { "2022-09-27" }
  end
end
