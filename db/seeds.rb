User.create!(name:  "Sodateyo User",
    email: "sodateyo@sample.com",
    password:              "password",
    password_confirmation: "password",
    admin: true)

99.times do |n|
name  = Faker::Name.name
email = "sodateyo-#{n+1}@sample.com"
password = "password"
User.create!(name:  name,
      email: email,
      password:              password,
      password_confirmation: password)
end

#都道府県情報を作成
path = Rails.root.join('db', 'prefectures.json')
prefectures = ActiveSupport::JSON.decode(File.read(path))['prefectures']
prefectures.each do |prefecture|
    Prefecture.create!(
        name: prefecture['name'])
end
