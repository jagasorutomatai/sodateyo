FactoryBot.define do
  sequence :posts_title do |i|
    "タイトル#{i}"
  end

  factory :post1, class: Post  do
    title { "testtitle" }
    content { "testcontent" }
    planted_at { '2020-06-23' }
    picture { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/image.png')) }
    association :user, factory: :other
    association :prefecture
  end

  factory :posts, class: Post do
    title { generate :posts_title }
    content { "#{title}の内容" }
    planted_at { '2020-06-23' }
    picture { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/image.png')) }
    association :user, factory: :other
    association :prefecture
  end
end
