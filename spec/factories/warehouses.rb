FactoryBot.define do
  factory :warehouse do
    name {'Aeroporto SP'}
    code {'GRU'}
    city {'Guarulhos'}
    area {'100_000'}
    address {'Avenida do Aeroporto, 100'}
    cep {'15000-000'}
    description {'Galpão destinado para cargas internacionais'}
  end
end
