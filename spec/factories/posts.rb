FactoryBot.define do
  factory :post1, class: Post  do
    title { "testtitle" }
    content { "testcontent" }
    planted_at { '2020-06-23' }
    picture { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/image.png')) }
    association :user, factory: :other
    association :prefecture
  end
end
