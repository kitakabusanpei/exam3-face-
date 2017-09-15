# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

100.times do |n|
  email = Faker::Internet.email
  name = "name"
  password = "password"
  User.create!(email: email,
               password: password,
               password_confirmation: password,
               name: name,
               )
end

n = 1
m = 1
while n <= 100
  Topic.create(content: "あああ",
               user_id: n
  )
  Comment.create(content: "コメコメ"
                 topic_id: m,
                 user_id: n
  )
  m = m + 1
  n = n + 1
end
