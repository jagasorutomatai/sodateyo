FactoryBot.define do
  factory :post, class: Post  do
    title { "testtitle" }
    content { "testcontent" }
    picture { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/support/image.png')) }
    association :user
  end
end
