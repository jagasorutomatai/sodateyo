FactoryBot.define do
  factory :user do
    name { 'testuser' }
    email { 'testuser@sample.co.jp' }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
