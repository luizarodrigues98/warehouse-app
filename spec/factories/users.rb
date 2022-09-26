FactoryBot.define do
  factory :user do
    name { 'user' }
    email { "joao@email.com" }
    password {'password'}
  end
end
