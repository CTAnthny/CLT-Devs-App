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

    before(:create) do |project|
      member = Member.last || FactoryBot.create(:member)
      project.creator_id = member.id
    end
  end

  factory :project_membership do
    member
    project
  end
end
