FactoryBot.define do
  sequence :users_name do |i|
    "testuser#{i}"
  end

  factory :user, class: User do
    name { 'testuser' }
    email { 'testuser@sample.com' }
    password_digest { User.digest('password') }
    admin { true }
  end

  factory :other, class: User do
    name { 'otheruser' }
    email { 'otheruser@sample.com' }
    password_digest { User.digest('password') }
    admin { false }
  end

  factory :admin, class: User do
    name { 'adminuser' }
    email { 'adminuser@sample.com' }
    password_digest { User.digest('password') }
    admin { true }
  end

  factory :users, class: User do
    name { generate :users_name }
    email { "#{name}@sample.com" }
    password_digest { User.digest('password') }
    admin { false }
  end
end
