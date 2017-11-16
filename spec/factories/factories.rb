FactoryBot.define do
  factory :member do
    sequence(:email) { |n| "person#{n}@example.com"}
    first_name 'John'
    last_name 'Smith'
    password 'password'
  end
end
