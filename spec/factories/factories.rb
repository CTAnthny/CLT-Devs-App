FactoryBot.define do
  factory :member do
    # sequence(:id) { |n| "#{n}" }
    sequence(:email) { |n| "person#{n}@example.com" }
    first_name 'John'
    last_name 'Smith'
    password 'password'

    # initialize_with { Member.find_or_create_by(id: id) }
    # transient do
    #   sequence(:id) { |n| "#{n}" }
    # end
    #
    # after(:create) do |member|
    #   member.projects.create(:project, creator_id: member.id)
    # end
  end

  factory :project do
    # association :member
    # member { create(:member) }
    sequence(:name) { |n| "Project#{n}" }
    description "MyText"
    # creator_id member.id
    # association :project_membership, factory: :member, strategy: :find_or_create_by, creator_id: member.id
    # association :project_membership, factory: :member, creator_id: member.id
  end

  factory :project_membership do
    member
    project
  end
end
