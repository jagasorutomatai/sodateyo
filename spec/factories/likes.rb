FactoryBot.define do
  factory :like, class: Like do
    association :user, factory: :user
    association :post, factory: :post1
  end
end
