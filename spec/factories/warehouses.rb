FactoryBot.define do
  factory :warehouse do
    name {Faker::Company.name}
    code {'GRU'}
    city {Faker::Address.city}
    area {'100_000'}
    address {Faker::Address.street_address }
    cep {'15000-000'}
    description {'Galpão destinado para cargas internacionais'}
  end
end
