FactoryBot.define do
  factory :supplier do
    corporate_name {Faker::Company.name}
    brand_name {Faker::Company.suffix}
    registration_number {CNPJ.generate}
    city {Faker::Address.city}
    full_address {Faker::Address.street_address }
    state {Faker::Address.state}
    email { Faker::Internet.email  }
  end
end
