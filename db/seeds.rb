# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#管理者アカウント作成
User.create!(name:  "Example User",
    email: "example@railstutorial.org",
    password:              "foobar",
    password_confirmation: "foobar",
    admin: true)

#その他アカウントを99個作成
99.times do |n|
    #ユーザー名も日本語化
    Faker::Config.locale = 'ja'
    name  = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org"
    password = "password"
    User.create!(name:  name,
        email: email,
        password:              password,
        password_confirmation: password)
end

#最初の6アカウントへ50個分のPlaceを追加
users = User.order(:created_at).take(6)
50.times do
    Faker::Config.locale = 'ja'
    place_name = Faker::University.name
    address1 = Faker::Address.state
    address2 = Faker::Address.city
    address3 = Faker::Address.street_name
    address4 = Faker::Address.building_number
    place_address = address1 + address2 + address3 + address4
    users.each { |user| user.place.create!(name: place_name, address: place_address) }
end
