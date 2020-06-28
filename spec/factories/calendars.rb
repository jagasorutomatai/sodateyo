FactoryBot.define do
  factory :january, class: Calendar do
    month { "2020-01-01" }
    content { "カレンダーの内容" }
    temperature { 24 }
    picture { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/image.png')) }
    planted_flag { true }
    harvested_flag { false }
    association :post, factory: :post1
  end
end
