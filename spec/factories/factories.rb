FactoryBot.define do
  factory :member do
    sequence(:email) { |n| "person#{n}@example.com" }
    first_name 'John'
    last_name 'Smith'
    password 'password'
  end

  factory :project do
    sequence(:name) { |n| "Project#{n}" }
    description "MyText"
  end

  factory :project_membership do
    member
    project
  end
end
