FactoryBot.define do
  factory :calendar do
    month { "2020-06-11" }
    content { "MyText" }
    temperature { "" }
    planted_at { "2020-06-11" }
    harvested_at { "2020-06-11" }
    post { nil }
  end
end
