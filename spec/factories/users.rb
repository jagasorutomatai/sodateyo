FactoryBot.define do
  factory :user do
    name { 'testuser' }
    email { 'testuser@sample.com' }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
