FactoryBot.define do
  factory :member do
    sequence(:email) { |n| "person#{n}@example.com" }
    first_name 'John'
    last_name 'Smith'
    password 'password'
  end

  factory :project do
    sequence(:name) { |n| "Project#{n}" }
    sequence(:description) { |n| "ProjectDescriptionText#{n}" }
    sequence(:updated_at) { |n| Time.now + n }

    before(:create) do |project|
      member = Member.last || FactoryBot.create(:member)
      project.creator_id = member.id
    end
  end

  factory :task do
    sequence(:name) { |n| "Task#{n}" }
    sequence(:description) { |n| "TaskDescriptionText#{n}" }
    keywords Faker::Lovecraft.words
    needs Faker::RickAndMorty.quote
  end

  factory :project_membership do
    member
    project
  end

  factory :task_membership do
    member
    task
  end
end
