FactoryBot.define do
  factory :plant, class: Plant do
    name { 'testplantname' }
    description { 'testplantdescription' }
    picture { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/support/image.png')) }
    calendar_id { 1 }
  end
end
