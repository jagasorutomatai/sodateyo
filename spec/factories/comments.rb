FactoryBot.define do
  factory :comment, class: Comment  do
    content { "コメント" }
    association :user, factory: :user
    association :post, factory: :post1
  end
end
